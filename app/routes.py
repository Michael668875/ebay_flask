from flask import (
    Blueprint,
    render_template,
    redirect,
    url_for,
    abort,
    request,
    make_response
)

from app.models import Listing, Model, Specs, ThinkPadModel
from app import db
from sqlalchemy.orm import joinedload
from sqlalchemy import text

bp = Blueprint("main", __name__)

SPEC_FILTERS = {
    "ram": Specs.ram,
    "cpu": Specs.cpu,
    "storage": Specs.storage,
    "storage_type": Specs.storage_type
}

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


# -------------------------------------------------
# Helpers
# -------------------------------------------------

ENABLED_MARKETS = ["EBAY_US", "EBAY_GB", "EBAY_DE", "EBAY_AU"]

def get_enabled_markets():
    """Return enabled marketplaces as dict keyed by country code."""
    return {m.split("_")[1].lower(): m for m in ENABLED_MARKETS}
    


# -------------------------------------------------
# Root → Redirect to preferred country
# -------------------------------------------------

@bp.route("/")
def index():
    preferred = request.cookies.get("preferred_country", "us")
    return redirect(url_for("main.country_home", country=preferred))
   # render_template("listings.html")

# -------------------------------------------------
# Country Home Page
# Example: /us/
# -------------------------------------------------

@bp.route("/<country>/")
def country_home(country):

    country = country.lower()
    markets = get_enabled_markets()

    if country not in markets:
        abort(404)

    marketplace = markets[country]
    sort = request.args.get("sort", "price")

    query = (
        Listing.query
        .join(Listing.model)
        .outerjoin(Listing.specs)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace == marketplace
        )
    )

    ram_options = (
        db.session.query(Specs.ram)
        .join(Listing)
        .filter(
            Listing.marketplace == marketplace,
            Listing.status == "ACTIVE"
        )
        .distinct()
        .order_by(Specs.ram)
        .all()
    )

    cpu_options = (
        db.session.query(Specs.cpu)
        .join(Listing)
        .filter(
            Listing.marketplace == marketplace,
            Listing.status == "ACTIVE"
        )
        .distinct()
        .order_by(Specs.cpu)
        .all()
    )

    ram_options = [r[0] for r in ram_options if r[0]]
    cpu_options = [c[0] for c in cpu_options if c[0]]


    #for param, column in SPEC_FILTERS.items():
    #    value = request.args.get(param)
    #    if value:
    #        query = query.filter(column == value)

    filters = {}

    for name, column in SPEC_FILTERS.items():

        values = (
            db.session.query(column)
            .join(Listing)
            .filter(
                Listing.marketplace == marketplace,
                Listing.status == "ACTIVE"
            )
            .distinct()
            .order_by(column)
            .all()
        )

        filters[name] = [v[0] for v in values if v[0]]

    listings = query.order_by(Listing.price.asc()).limit(100).all()

    stats = {
        "lowest": 350,
        "average": 520,
        "highest": 900
    }

    return render_template(
            "listings.html",
            listings=listings,
            country=country,
            filters=filters,
            ram_options=ram_options,
            cpu_options=cpu_options,
            stats=stats
        )    


# -------------------------------------------------
# Model Page
# Example: /us/thinkpad-t480/
# -------------------------------------------------

@bp.route("/<country>/<model_slug>/")
def model_page(country, model_slug):
    country = country.lower()
    markets = get_enabled_markets()

    if country not in markets:
        abort(404)

    marketplace = markets[country]

    listings = (
        Listing.query
        .join(Listing.model)
        .join(Model.canon_model)
        .options(
            joinedload(Listing.model),
            joinedload(Listing.specs)
        )
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace == marketplace,
            ThinkPadModel.slug == model_slug
        )
        .order_by(Listing.price.asc())
        .limit(100)
        .all()
    )

    if not listings:
        #abort(404)
        page = render_template("none.html")
    else:
        page = render_template(
        "model.html",
        listings=listings,
        country=country,
        model_slug=model_slug
    )

    return page


# -------------------------------------------------
# Set Preferred Country Cookie
# -------------------------------------------------

@bp.route("/set-country/<country>/")
def set_country(country):
    country = country.lower()
    markets = get_enabled_markets()

    if country not in markets:
        abort(404)

    response = make_response(
        redirect(request.referrer or url_for("main.country_home", country=country))
    )
    response.set_cookie("preferred_country", country, max_age=60 * 60 * 24 * 30)

    return response

@bp.route("/<country>/deals")
def deals(country):

    marketplace = f"EBAY_{country.upper()}"
    sort = request.args.get("sort", "price")

    order_clause = {
        "price": "cheapest_price ASC",
        "listings": "listing_count DESC",
        "newest": "newest_listing DESC"
    }.get(sort, "cheapest_price ASC")

    rows = db.session.execute(text(f"""
        SELECT
            m.id AS model_id,
            m.name AS model_name,
            ml.slug,
            MIN(l.price) AS cheapest_price,
            COUNT(*) AS listing_count,
            MAX(l.first_seen) AS newest_listing,
            (
                SELECT ebay_item_id
                FROM listings l2
                WHERE l2.model_id = m.id
                AND l2.status = 'ACTIVE'
                AND l2.marketplace = :marketplace
                ORDER BY l2.price ASC
                LIMIT 1
            ) AS cheapest_item
        FROM listings l
        JOIN models m ON m.id = l.model_id
        JOIN model_list ml ON ml.id = m.canon_model_id
        WHERE l.status = 'ACTIVE'
        AND l.marketplace = :marketplace
        GROUP BY m.id, m.name, ml.slug
        ORDER BY {order_clause}
        LIMIT 50
    """), {"marketplace": marketplace}).fetchall()

    return render_template(
        "deals.html",
        rows=rows,
        country=country,
        sort=sort
    )

@bp.route("/<country>/deals/<model_slug>")
def deal_model(country, model_slug):

    marketplace = f"EBAY_{country.upper()}"

    rows = db.session.execute(text("""
        SELECT
            l.price,
            l.ebay_item_id,
            l.title,
            l.item_url
        FROM listings l
        JOIN models m ON m.id = l.model_id
        JOIN model_list ml ON ml.id = m.canon_model_id
        WHERE l.status = 'ACTIVE'
        AND l.marketplace = :marketplace
        AND ml.slug = :slug
        ORDER BY l.price ASC
        LIMIT 50
    """), {
        "marketplace": marketplace,
        "slug": model_slug
    }).fetchall()

    return render_template(
        "deal_model.html",
        rows=rows,
        country=country,
        slug=model_slug
    )


@bp.route("/<country>/price-drops")
def price_drops(country):

    marketplace = f"EBAY_{country.upper()}"

    rows = db.session.execute(text("""
        WITH price_changes AS (
            SELECT
                m.name AS model_name,
                ml.slug,
                l.ebay_item_id,
                ph.price AS new_price,
                LAG(ph.price) OVER (
                    PARTITION BY ph.listing_id
                    ORDER BY ph.recorded_at
                ) AS old_price
            FROM price_history ph
            JOIN listings l ON l.id = ph.listing_id
            JOIN models m ON m.id = l.model_id
            JOIN model_list ml ON ml.id = m.canon_model_id
            WHERE l.status = 'ACTIVE'
            AND l.marketplace = :marketplace
        )

        SELECT
            model_name,
            slug,
            ebay_item_id,
            old_price,
            new_price,
            (old_price - new_price) AS drop_amount
        FROM price_changes
        WHERE new_price < old_price
        ORDER BY drop_amount DESC
        LIMIT 50
    """), {"marketplace": marketplace}).fetchall()

    return render_template(
        "price_drops.html",
        rows=rows,
        country=country
    )

@bp.route("/<country>/best-deals")
def best_deals(country):

    marketplace = f"EBAY_{country.upper()}"

    rows = db.session.execute(text("""
        WITH model_prices AS (
            SELECT
                model_id,
                AVG(price) AS avg_price
            FROM listings
            WHERE status = 'ACTIVE'
            AND marketplace = :marketplace
            GROUP BY model_id
        )

        SELECT
            m.name AS model_name,
            ml.slug,
            l.ebay_item_id,
            l.price,
            mp.avg_price,
            (mp.avg_price - l.price) AS discount_amount,
            ROUND(((mp.avg_price - l.price) / mp.avg_price) * 100) AS discount_percent
        FROM listings l
        JOIN model_prices mp ON mp.model_id = l.model_id
        JOIN models m ON m.id = l.model_id
        JOIN model_list ml ON ml.id = m.canon_model_id
        WHERE l.status = 'ACTIVE'
        AND l.marketplace = :marketplace
        AND l.price < mp.avg_price * 0.75
        ORDER BY discount_percent DESC
        LIMIT 50
    """), {"marketplace": marketplace}).fetchall()

    return render_template(
        "best_deals.html",
        rows=rows,
        country=country
    )

@bp.route("/<country>/<slug>-price")
def model_price(country, slug):

    marketplace = f"EBAY_{country.upper()}"

    stats = db.session.execute(text("""
        SELECT
            m.name,
            ml.slug,
            MIN(l.price) AS lowest_price,
            AVG(l.price) AS avg_price,
            MAX(l.price) AS highest_price,
            COUNT(*) AS listing_count
        FROM listings l
        JOIN models m ON m.id = l.model_id
        JOIN model_list ml ON ml.id = m.canon_model_id
        WHERE l.status = 'ACTIVE'
        AND l.marketplace = :marketplace
        AND ml.slug = :slug
        GROUP BY m.name, ml.slug
    """), {
        "marketplace": marketplace,
        "slug": slug
    }).first()

    return render_template(
        "model_price.html",
        stats=stats,
        country=country
    )

@bp.route("/<country>/thinkpad-models")
def thinkpad_models(country):

    marketplace = f"EBAY_{country.upper()}"

    rows = db.session.execute(text("""
        SELECT
            m.name,
            ml.slug,
            MIN(l.price) AS lowest_price,
            COUNT(*) AS listing_count
        FROM listings l
        JOIN models m ON m.id = l.model_id
        JOIN model_list ml ON ml.id = m.canon_model_id
        WHERE l.status = 'ACTIVE'
        AND l.marketplace = :marketplace
        GROUP BY m.id, m.name, ml.slug
        ORDER BY m.name
    """), {"marketplace": marketplace}).fetchall()

    return render_template(
        "thinkpad_models.html",
        rows=rows,
        country=country
    )