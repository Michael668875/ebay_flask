from flask import abort
    
from app.models import Listing, Model, Specs, ThinkPadModel
from app import db
from sqlalchemy.orm import joinedload
from sqlalchemy import func

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


def get_country_context_or_404(country):
    """
    Normalize/validate country using your existing market context helper.
    Returns: (country, marketplaces, currency)
    """
    return get_market_context(country)

def get_model_by_slug(slug):
    """
    Return the canonical ThinkPad model row for a slug, or None.
    """
    return ThinkPadModel.query.filter_by(slug=slug).first()

def active_listings_query_for_model(model_id, marketplaces):
    """
    Returns a Listing query for a canonical model.
    1:1 Model → Listing mapping, so no deduplication needed.
    """
    return (
        Listing.query
        .join(Model, Model.listing_id == Listing.id)
        .options(joinedload(Listing.model), joinedload(Listing.specs))
        .filter(
            Model.canon_model_id == model_id,
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
        )
    )

def canonical_model_stats(model_id, marketplaces):
    """
    Returns one row of aggregate stats for a canonical model.
    Assumes one Model per Listing (1:1 relationship).
    """
    return (
        db.session.query(
            func.min(Listing.price).label("lowest_price"),
            func.avg(Listing.price).label("avg_price"),
            func.max(Listing.price).label("highest_price"),
            func.count(Listing.id).label("listing_count"),
        )
        .join(Model, Model.listing_id == Listing.id)
        .filter(
            Model.canon_model_id == model_id,
            Listing.status == "ACTIVE",
            Listing.marketplace.in_(marketplaces),
        )
        .first()
    )