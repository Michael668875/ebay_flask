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

bp = Blueprint("main", __name__)




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
            Listing.marketplace == marketplace,
            Listing.status == "ACTIVE"
        )
    )

    if sort == "price":
        query = query.order_by(Listing.price.asc())

    elif sort == "cpu":
        query = query.order_by(Specs.cpu.asc())

    elif sort == "ram":
        query = query.order_by(Specs.ram.desc())

    listings = query.limit(100).all()

    return render_template(
        "listings.html",
        listings=listings,
        country=country
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
        .outerjoin(Listing.specs)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace == marketplace,
            Model.slug == model_slug
        )
        .order_by(Listing.price.asc())
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