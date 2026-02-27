from flask import (
    Blueprint,
    render_template,
    redirect,
    url_for,
    abort,
    request,
    make_response
)

from app.models import Listing, Marketplace, Product

bp = Blueprint("main", __name__)


# -------------------------------------------------
# Helpers
# -------------------------------------------------

def get_enabled_markets():
    """Return enabled marketplaces as dict keyed by country code."""
    markets = Marketplace.query.filter_by(enabled=True).all()
    return {m.country_code.lower(): m for m in markets}


# -------------------------------------------------
# Root → Redirect to preferred country
# -------------------------------------------------

@bp.route("/")
def index():
    preferred = request.cookies.get("preferred_country", "us")
    return redirect(url_for("main.country_home", country=preferred))


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

    # Show cheapest active listings in that country
    listings = (
        Listing.query
        .filter_by(marketplace=marketplace.marketplace_id, status="ACTIVE")
        .join(Listing.product)
        .order_by(Listing.price.asc())
        .limit(50)
        .all()
    )

    return render_template(
        "home.html",
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
        .join(Listing.product)
        .filter(
            Listing.status == "ACTIVE",
            Listing.marketplace == marketplace.marketplace_id,
            Product.slug == model_slug
        )
        .order_by(Listing.price.asc())
        .all()
    )

    if not listings:
        abort(404)

    return render_template(
        "model.html",
        listings=listings,
        country=country,
        model_slug=model_slug
    )


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