from decimal import Decimal
from datetime import datetime
from app.extensions import db
from app.models import TempSummaries, TempDetails
from app.services.field_map import FIELD_MAP
import re
from difflib import get_close_matches


def clean_text(text: str) -> str:
    # remove emojis and weird symbols
    text = re.sub(r'[\U00010000-\U0010ffff]', '', text)
    return text.strip()

def clean_storage_type(value):
    remove = [
        "(Solid State Drive)",
        "(Hard Disk Drive)",
        "(Non-Volatile Memory Express)"
    ]
    for r in remove:
        value = value.replace(r, "")
    return value.strip()


def save_temp_summaries(items):
    """
    Inserts json data into temp_summaries table in db.
    """

    # Load all rows once
    ids = [item["itemId"] for item in items if "itemId" in item]

    existing = {
        row.ebay_item_id: row
        for row in TempSummaries.query.filter(
            TempSummaries.ebay_item_id.in_(ids)
        )
    }

    inserted = 0

    for item in items:
        item_id = item.get("itemId")
        if not item_id:
            continue

        price_info = item.get("price", {})
        price_value = price_info.get("value")
        category_id = item.get("leafCategoryIds", [None])[0]
        creation_date = None
        location = item.get("itemLocation", {})
        if item.get("itemCreationDate"):
            creation_date = datetime.fromisoformat(
                item["itemCreationDate"].replace("Z", "+00:00")
            )

        listing = existing.get(item_id)

        if listing:
            continue  # skip creating a new listing

        # Create temporary listing with category
        listing = TempSummaries(
            category_id=category_id,
            ebay_item_id=item_id,
            title = clean_text(item.get("title", "")),
            price=Decimal(str(price_value)) if price_value else None,
            currency= price_info.get("currency"),
            condition=item.get("condition"),
            listing_type=",".join(item.get("buyingOptions", [])),
            marketplace=item.get("marketplace_id"),            
            item_country = location.get("country"),
            item_url=item.get("itemWebUrl"),
            creation_date = creation_date            
        )
        db.session.add(listing)
        db.session.flush()       

        inserted += 1

    db.session.commit()
    print(f"Inserted {inserted} into temp db.")


def valid_capacity(value):
    if not value:
        return False
    v = value.lower()
    if v.startswith("0"):
        return False
    if v in ["none", "n/a", "unknown"]:
        return False
    return True

# Get all canonical models from the database
CANON = [row.name for row in db.ThinkPadModel.query.with_entities(db.ThinkPadModel.name).all()]

def parse_model(item, CANON_MODELS=CANON):
    """
    Determine the canonical model for a listing.

    Args:
        item (dict): eBay item dict with 'localizedAspects' and 'title'
        CANON_MODELS (list[str]): list of canonical model names

    Returns:
        str: matched canonical model or 'unknown' if no match
    """
    # -------------------------
    # Step 1: Check localizedAspects
    # -------------------------
    aspects = {a.get("name"): a.get("value") for a in item.get("localizedAspects", []) if a.get("name") and a.get("value")}
    model_aspect = aspects.get("Model") or aspects.get("model")  # common variations
    if model_aspect:
        if model_aspect in CANON_MODELS:
            return model_aspect
        partial_matches = [m for m in CANON_MODELS if model_aspect.lower() in m.lower()]
        if partial_matches:
            return partial_matches[0]

    # -------------------------
    # Step 2: Parse from title
    # -------------------------
    title = item.get("title", "")
    if title:
        # Regex for typical ThinkPad-style models
        pattern = r"(T\d{2,3}[a-zA-Z]?(?:\sGen\s\d)?)"
        matches = re.findall(pattern, title, flags=re.IGNORECASE)
        for match in matches:
            if match in CANON_MODELS:
                return match
            partial_matches = [m for m in CANON_MODELS if match.lower() in m.lower()]
            if partial_matches:
                return partial_matches[0]

        # Fallback: fuzzy match on full title
        closest = get_close_matches(title, CANON_MODELS, n=1, cutoff=0.6)
        if closest:
            return closest[0]

    # -------------------------
    # Step 3: No match
    # -------------------------
    return "unknown"


def save_temp_details(items):

    ids = [item["itemId"] for item in items if "itemId" in item]

    existing = {
        row.ebay_item_id: row
        for row in TempDetails.query.filter(
            TempDetails.ebay_item_id.in_(ids)
        )
    }

    updated = 0

    for item in items:

        item_id = item.get("itemId")
        if not item_id:
            continue

        listing = existing.get(item_id)

        if not listing:
            listing = TempDetails(ebay_item_id=item_id)
            db.session.add(listing)
            existing[item_id] = listing

        # -------------------------
        # Collect aspects
        # -------------------------
        aspects = {}

        for aspect in item.get("localizedAspects", []):
            name = aspect.get("name")
            value = aspect.get("value")

            if name and value:
                aspects[name] = value

        # -------------------------
        # Apply FIELD_MAP priority
        # -------------------------
        for field, config in FIELD_MAP.items():

            for key in config["keys"]:

                if key not in aspects:
                    continue


                value = aspects[key]

                # Only validate capacity fields
                if field in ["ram", "storage"] and not valid_capacity(value):
                    continue

                if field == "storage_type":
                    value = clean_storage_type(value)

                setattr(listing, field, value)
                break   # stop checking lower priority keys

        # -------------------------
        # Parse and assign model
        # -------------------------
        listing.model = parse_model(item)

        updated += 1

    db.session.commit()

    print(f"Updated {updated} temp_details.")





"""
Future upgrades you may want

Once your site grows, these upgrades help a lot:

1 Redis cache

Avoid repeated detail fetches.

2 Celery workers

Distributed scraping.

3 Spec normalization table

For flexible specs beyond ThinkPads.

4 Price anomaly detection

Alert when listings are under market value.

"""

