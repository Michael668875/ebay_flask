from flask import (
    Blueprint,
    render_template,
    redirect,
    url_for,
    abort,
    request,
    make_response,
    Response
)

from app.models import Listing, Model, Specs, ThinkPadModel, PriceHistory, ModelPriceStats
from app import db
from sqlalchemy.orm import joinedload
from sqlalchemy import asc, desc, func
from collections import OrderedDict
from datetime import datetime, timezone

bp = Blueprint("main", __name__)

SPEC_FILTERS = {
    "ram": Specs.ram,
    "cpu": Specs.cpu,
    "storage": Specs.storage,
    "storage_type": Specs.storage_type
}

COUNTRY_FLAGS = {
    "us": "🇺🇸",
    "au": "🇦🇺",
    "de": "🇩🇪",
    "gb": "🇬🇧",
}

CURRENCY_BY_COUNTRY = {
    "us": "USD",
    "au": "AUD",
    "de": "EUR",
    "gb": "GBP",
}

ENABLED_MARKETS = ["EBAY_US", "EBAY_GB", "EBAY_DE", "EBAY_AU"]

def get_enabled_markets():
    """Return enabled marketplaces as dict keyed by country code."""
    return {m.split("_")[1].lower(): m for m in ENABLED_MARKETS}

def get_market_context(country):
    country = country.lower()
    markets = get_enabled_markets()

    if country not in markets:
        abort(404)

    marketplaces = [markets[country]]
    currency = CURRENCY_BY_COUNTRY.get(country, "")

    return country, marketplaces, currency

@bp.app_errorhandler(404)
def not_found_error(error):
    return render_template("404.html"), 404

@bp.app_errorhandler(500)
def internal_error(error):
    db.session.rollback()
    return render_template("500.html"), 500

@bp.route("/robots.txt")
def robots():
    lines = [
        "User-agent: *",
        "Allow: /",
        f"Sitemap: {request.url_root.rstrip('/')}{url_for('main.sitemap_xml')}",
    ]
    return Response("\n".join(lines), mimetype="text/plain")


@bp.route("/sitemap.xml")
def sitemap_xml():
    from flask import Response, url_for, render_template
    from datetime import datetime, timezone

    today = datetime.now(timezone.utc).date().isoformat()
    pages = []

    # --- Static pages ---
    static_endpoints = [
        ("main.index", {}),
        ("main.about", {}),
        ("main.methodology", {}),
        ("main.privacy", {}),
        ("main.terms", {}),
        ("main.contact", {}),
    ]

    for endpoint, values in static_endpoints:
        pages.append({
            "loc": url_for(endpoint, _external=True, **values),
            "lastmod": today,
            "changefreq": "weekly",
            "priority": "0.8" if endpoint == "main.index" else "0.5",
        })

    # --- Country pages ---
    for country in COUNTRY_FLAGS.keys():
        pages.extend([
            {"loc": url_for("main.deals", country=country, _external=True), "lastmod": today, "changefreq": "daily", "priority": "0.9"},
            {"loc": url_for("main.best_deals", country=country, _external=True), "lastmod": today, "changefreq": "daily", "priority": "0.8"},
            {"loc": url_for("main.price_drops", country=country, _external=True), "lastmod": today, "changefreq": "daily", "priority": "0.7"},
            {"loc": url_for("main.thinkpad_models", country=country, _external=True), "lastmod": today, "changefreq": "weekly", "priority": "0.7"},
        ])

    # --- Model pages ---
    # Include only models that have stats for the marketplace with at least 5 listings
    models = ThinkPadModel.query.order_by(ThinkPadModel.slug.asc()).all()
    for model in models:
        if not model.slug:
            continue
        for country in COUNTRY_FLAGS.keys():
            # Get stats for this model + marketplace
            stats = ModelPriceStats.query.join(ModelPriceStats.model).filter(
                ModelPriceStats.model_id == model.id,
                ModelPriceStats.marketplace == country,
                ModelPriceStats.listing_count >= 5
            ).first()

            if not stats:
                continue  # skip models with too few listings in this country

            lastmod = stats.updated_at.date().isoformat() if stats.updated_at else today

            pages.append({
                "loc": url_for("main.model_price", country=country, slug=model.slug, _external=True),
                "lastmod": lastmod,
                "changefreq": "daily",
                "priority": "0.8",
            })

    xml = render_template("sitemap.xml", pages=pages)
    return Response(
        xml,
        mimetype="application/xml",
        headers={"Cache-Control": "public, max-age=3600"}
    )

DEFAULT_COUNTRY = "us"

@bp.app_context_processor
def inject_site_globals():
    country = request.view_args.get("country") if request.view_args else None

    if not country:
        country = request.cookies.get("country", DEFAULT_COUNTRY)

    country = (country or DEFAULT_COUNTRY).lower()

    return {
        "country": country,
        "country_flags": COUNTRY_FLAGS,
    }


@bp.after_app_request
def persist_country_cookie(response):
    if request.view_args and "country" in request.view_args:
        country = request.view_args["country"].lower()
        response.set_cookie("country", country, max_age=60 * 60 * 24 * 365)
    return response


@bp.app_template_filter("format_capacity")
def format_capacity(value):
    if value is None:
        return "—"

    if value >= 1024:
        tb = value / 1024
        return f"{tb:g}" + "TB"

    if value < 1:
        mb = value * 1024
        return f"{mb:g}" + "MB"

    return f"{value:g}" + "GB"

@bp.app_template_filter("format_ram")
def format_ram(value):
    """
    Specs.ram is stored in GB by the pipeline.
    Example: 8192 MB -> 8, 16 GB -> 16, 1 TB -> 1024
    """
    if value is None:
        return "—"

    try:
        value = float(value)
    except (TypeError, ValueError):
        return str(value)

    if value.is_integer():
        value = int(value)

    # ram is stored in GB in your DB
    return f"{value} GB"


@bp.app_template_filter("format_storage")
def format_storage(value):
    if value is None:
        return "—"

    try:
        value = float(value)
    except (TypeError, ValueError):
        return str(value)

    # storage is stored in GB in your DB
    if value >= 1024:
        tb = value / 1024
        if tb.is_integer():
            return f"{int(tb)} TB"
        return f"{tb:.1f} TB"

    if value.is_integer():
        return f"{int(value)} GB"

    return f"{value:.1f} GB"

MARKETPLACE_TO_COUNTRY = {
    "EBAY_US": "us",
    "EBAY_AU": "au",
    "EBAY_DE": "de",
    "EBAY_GB": "gb",
}

@bp.app_context_processor
def inject_helpers():
    def country_for_item(item, current_country):
        if current_country != "all":
            return current_country
        return MARKETPLACE_TO_COUNTRY.get(item.marketplace, "us")

    return {
        "country_for_item": country_for_item
    }



# -------------------------------------------------
# Root → Redirect to preferred country
# -------------------------------------------------

@bp.route("/")
def index():
    preferred = request.cookies.get("preferred_country", "us").lower()
    valid_countries = set(get_enabled_markets().keys()) | {"all"}

    if preferred not in valid_countries:
        preferred = "us"

    return redirect(url_for("main.country_home", country=preferred))

# -------------------------------------------------
# Country Home Page
# Example: /us/
# -------------------------------------------------


@bp.route("/<country>/")
def country_home(country):
    country, marketplaces, currency = get_market_context(country)

    sort = request.args.get("sort", "price")
    direction = request.args.get("direction", "asc")

    query = (
        Listing.query
        .join(Listing.model)
        .outerjoin(Listing.specs)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces)
        )
    )

    # Apply spec filters
    for param, column in SPEC_FILTERS.items():
        value = request.args.get(param)
        if value:
            query = query.filter(column == value)

    # Dropdown filter options
    filters = {}
    for name, column in SPEC_FILTERS.items():
        values = (
            db.session.query(column)
            .join(Listing)
            .filter(
                Listing.status == "ACTIVE",
                Listing.marketplace.in_(marketplaces)
            )
            .distinct()
            .order_by(column.asc().nullslast())
            .all()
        )
        filters[name] = [v[0] for v in values if v[0] is not None]

    SORT_COLUMNS = {
        "price": Listing.price,
        "cpu": Specs.cpu,
        "ram": Specs.ram,
        "storage": Specs.storage,
    }

    order_col = SORT_COLUMNS.get(sort, Listing.price)
    primary_sort = desc(order_col) if direction == "desc" else asc(order_col)
    primary_sort = primary_sort.nullslast()

    query = query.order_by(primary_sort if sort == "price" else primary_sort, Listing.price.asc())
    listings = query.limit(100).all()

    # Desired order of filter fields
    desired_order = ["cpu", "ram", "storage", "storage_type"]

    filters_ordered = OrderedDict()
    for key in desired_order:
        if key in filters:
            filters_ordered[key] = filters[key]
        else:
            filters_ordered[key] = []  # empty list if not present

    return render_template(
        "listings.html",
        listings=listings,
        country=country,
        filters=filters_ordered,
        currency=currency,
        country_flags=COUNTRY_FLAGS
    )

# -------------------------------------------------
# Model Page
# Example: /us/thinkpad-t480/
# -------------------------------------------------

@bp.route("/<country>/<model_slug>/")
def model_page(country, model_slug):
    country, marketplaces, currency = get_market_context(country)

    listings = (
        Listing.query
        .join(Listing.model)
        .join(ThinkPadModel, ThinkPadModel.id == Model.canon_model_id)
        .options(joinedload(Listing.model), joinedload(Listing.specs))
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
            ThinkPadModel.slug == model_slug
        )
        .order_by(Listing.price.asc())
        .limit(100)
        .all()
    )

    if not listings:
        page = render_template("none.html")
    else:
        page = render_template(
            "model.html",
            listings=listings,
            country=country,
            model_slug=model_slug,
            currency=currency,
            country_flags=COUNTRY_FLAGS
        )

    return page


# -------------------------------------------------
# Set Preferred Country Cookie
# -------------------------------------------------

@bp.route("/set-country/<country>/")
def set_country(country):
    country = country.lower()
    valid_countries = set(get_enabled_markets().keys())

    if country not in valid_countries:
        abort(404)

    response = make_response(
        redirect(request.referrer or url_for("main.country_home", country=country))
    )
    response.set_cookie("preferred_country", country, max_age=60 * 60 * 24 * 30)

    return response


@bp.route("/<country>/deals")
def deals(country):
    country, marketplaces, currency = get_market_context(country)

    sort = request.args.get("sort", "price")

    # subquery: cheapest listing per model
    cheapest_subq = (
        db.session.query(
            Listing.model_id.label("model_id"),
            func.min(Listing.price).label("cheapest_price"),
            func.count(Listing.id).label("listing_count"),
            func.max(Listing.first_seen).label("newest_listing"),
        )
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces)
        )
        .group_by(Listing.model_id)
        .subquery()
    )

    # correlated subquery for cheapest ebay item id
    cheapest_item_subq = (
        db.session.query(Listing.ebay_item_id)
        .filter(
            Listing.model_id == Model.id,
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces)
        )
        .order_by(Listing.price.asc())
        .limit(1)
        .correlate(Model)
        .scalar_subquery()
    )

    query = (
        db.session.query(
            Model.id.label("model_id"),
            Model.name.label("model_name"),
            ThinkPadModel.slug.label("slug"),
            cheapest_subq.c.cheapest_price,
            cheapest_subq.c.listing_count,
            cheapest_subq.c.newest_listing,
            cheapest_item_subq.label("cheapest_item"),
        )
        .join(cheapest_subq, cheapest_subq.c.model_id == Model.id)
        .join(ThinkPadModel, Model.canon_model_id == ThinkPadModel.id)
    )

    if sort == "listings":
        query = query.order_by(desc(cheapest_subq.c.listing_count), asc(cheapest_subq.c.cheapest_price))
    elif sort == "newest":
        query = query.order_by(desc(cheapest_subq.c.newest_listing), asc(cheapest_subq.c.cheapest_price))
    else:  # price
        query = query.order_by(asc(cheapest_subq.c.cheapest_price))

    rows = query.limit(50).all()

    # -----------------------------
    # BEST DEAL MODEL IDS
    # -----------------------------
    avg_subq = (
        db.session.query(
            Listing.model_id.label("model_id"),
            func.avg(Listing.price).label("avg_price")
        )
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces)
        )
        .group_by(Listing.model_id)
        .subquery()
    )

    best_deal_model_rows = (
        db.session.query(Listing.model_id)
        .join(avg_subq, Listing.model_id == avg_subq.c.model_id)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
            Listing.price < avg_subq.c.avg_price * 0.75
        )
        .distinct()
        .all()
    )

    best_deal_model_ids = {row.model_id for row in best_deal_model_rows}

    return render_template(
        "deals.html",
        rows=rows,
        country=country,
        sort=sort,
        currency=currency,
        country_flags=COUNTRY_FLAGS,
        best_deal_model_ids=best_deal_model_ids,
    )

@bp.route("/<country>/deals/<model_slug>")
def deals_model(country, model_slug):
    country, marketplaces, currency = get_market_context(country)

    rows = (
        db.session.query(
            Listing.price,
            Listing.ebay_item_id,
            Listing.title,
            Listing.item_url,
            Listing.currency,   # useful when country == "all"
        )
        .join(Model, Model.id == Listing.model_id)
        .join(ThinkPadModel, ThinkPadModel.id == Model.canon_model_id)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
            ThinkPadModel.slug == model_slug,
        )
        .order_by(Listing.price.asc())
        .limit(50)
        .all()
    )

    return render_template(
        "deals_model.html",
        rows=rows,
        country=country,
        slug=model_slug,
        currency=currency,
        country_flags=COUNTRY_FLAGS,
    )

@bp.route("/<country>/price-drops")
def price_drops(country):
    country, marketplaces, currency = get_market_context(country)

    old_price = func.lag(PriceHistory.price).over(
        partition_by=PriceHistory.listing_id,
        order_by=PriceHistory.recorded_at
    )

    price_changes_subq = (
        db.session.query(
            Model.name.label("model_name"),
            ThinkPadModel.slug.label("slug"),
            Listing.ebay_item_id.label("ebay_item_id"),
            PriceHistory.price.label("new_price"),
            old_price.label("old_price"),
            Listing.currency.label("currency"),
        )
        .join(Listing, Listing.id == PriceHistory.listing_id)
        .join(Model, Model.id == Listing.model_id)
        .join(ThinkPadModel, ThinkPadModel.id == Model.canon_model_id)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
        )
        .subquery()
    )

    rows = (
        db.session.query(
            price_changes_subq.c.model_name,
            price_changes_subq.c.slug,
            price_changes_subq.c.ebay_item_id,
            price_changes_subq.c.old_price,
            price_changes_subq.c.new_price,
            (price_changes_subq.c.old_price - price_changes_subq.c.new_price).label("drop_amount"),
            price_changes_subq.c.currency,
        )
        .filter(
            price_changes_subq.c.old_price.isnot(None),
            price_changes_subq.c.new_price < price_changes_subq.c.old_price,
        )
        .order_by(desc("drop_amount"))
        .limit(50)
        .all()
    )

    return render_template(
        "price_drops.html",
        rows=rows,
        country=country,
        currency=currency,
        country_flags=COUNTRY_FLAGS,
    )

@bp.route("/<country>/best-deals")
def best_deals(country):
    country, marketplaces, currency = get_market_context(country)

    model_prices_subq = (
        db.session.query(
            Listing.model_id.label("model_id"),
            func.avg(Listing.price).label("avg_price"),
        )
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
        )
        .group_by(Listing.model_id)
        .subquery()
    )

    discount_amount = (model_prices_subq.c.avg_price - Listing.price)
    discount_percent = func.round((discount_amount / model_prices_subq.c.avg_price) * 100)

    rows = (
        db.session.query(
            Model.name.label("model_name"),
            ThinkPadModel.slug.label("slug"),
            Listing.ebay_item_id,
            Listing.price,
            Listing.item_url,
            model_prices_subq.c.avg_price,
            discount_amount.label("discount_amount"),
            discount_percent.label("discount_percent"),
            Listing.currency,
        )
        .join(model_prices_subq, model_prices_subq.c.model_id == Listing.model_id)
        .join(Model, Model.id == Listing.model_id)
        .join(ThinkPadModel, ThinkPadModel.id == Model.canon_model_id)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
            Listing.price < model_prices_subq.c.avg_price * 0.75,
        )
        .order_by(desc(discount_percent), asc(Listing.price))
        .limit(50)
        .all()
    )

    return render_template(
        "best_deals.html",
        rows=rows,
        country=country,
        currency=currency,
        country_flags=COUNTRY_FLAGS,
    )

@bp.route("/<country>/<slug>-price")
def model_price(country, slug):
    country, marketplaces, currency = get_market_context(country)

    stats = (
        db.session.query(
            Model.name.label("name"),
            ThinkPadModel.slug.label("slug"),
            func.min(Listing.price).label("lowest_price"),
            func.avg(Listing.price).label("avg_price"),
            func.max(Listing.price).label("highest_price"),
            func.count(Listing.id).label("listing_count"),
        )
        .join(Model, Model.id == Listing.model_id)
        .join(ThinkPadModel, ThinkPadModel.id == Model.canon_model_id)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
            ThinkPadModel.slug == slug,
        )
        .group_by(Model.name, ThinkPadModel.slug)
        .first()
    )

    return render_template(
        "model_price.html",
        stats=stats,
        country=country,
        currency=currency,
        country_flags=COUNTRY_FLAGS,
    )

@bp.route("/<country>/thinkpad_models")
def thinkpad_models(country):
    country, marketplaces, currency = get_market_context(country)

    rows = (
        db.session.query(
            Model.name.label("name"),
            ThinkPadModel.slug.label("slug"),
            func.min(Listing.price).label("lowest_price"),
            func.count(Listing.id).label("listing_count"),
        )
        .join(Model, Model.id == Listing.model_id)
        .join(ThinkPadModel, ThinkPadModel.id == Model.canon_model_id)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
        )
        .group_by(Model.id, Model.name, ThinkPadModel.slug)
        .order_by(Model.name.asc())
        .all()
    )

    return render_template(
        "thinkpad_models.html",
        rows=rows,
        country=country,
        currency=currency,
        country_flags=COUNTRY_FLAGS,
    )


@bp.route("/about")
def about():
    return render_template("about.html")


@bp.route("/how-it-works")
def methodology():
    return render_template("methodology.html")


@bp.route("/privacy")
def privacy():
    return render_template("privacy.html")


@bp.route("/terms")
def terms():
    return render_template("terms.html")


@bp.route("/contact")
def contact():
    return render_template("contact.html")