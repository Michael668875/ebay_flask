from flask import (
    Blueprint,
    render_template,
    redirect,
    url_for,
    abort,
    request,
    make_response
)

from app.models import Listing, Model, Specs
from app import db
from sqlalchemy.orm import joinedload

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


    for param, column in SPEC_FILTERS.items():
        value = request.args.get(param)
        if value:
            query = query.filter(column == value)

    listings = query.order_by(Listing.price.asc()).limit(100).all()

    return render_template(
            "listings.html",
            listings=listings,
            country=country,
            ram_options=ram_options,
            cpu_options=cpu_options
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
        .options(
            joinedload(Listing.model),
            joinedload(Listing.specs)
        )
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace == marketplace,
            Model.slug == model_slug
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

