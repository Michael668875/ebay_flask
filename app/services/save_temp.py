from decimal import Decimal, InvalidOperation
from datetime import datetime
from app import db
from app.models import TempSummaries, TempDetails
from app.services.field_map import FIELD_MAP
import re


def clean_text(text: str) -> str:
    # remove emojis and weird symbols
    text = re.sub(r'[\U00010000-\U0010ffff]', '', text)
    return text.strip()

def clean_storage_type(value):
    remove = [
        "Solid State Drive",
        "Hard Disk Drive",
        "Non-Volatile Memory Express",
        "(",
        ")",
        "Solid-State-Drive",
        "wurde solide"
    ]
    for r in remove:
        value = value.replace(r, "")
    return value.strip()


def save_temp_summaries(items):
    
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




# -------------------------
# Helper functions
# -------------------------
def valid_capacity(value):
    """Check if RAM/storage value is valid."""
    if not value:
        return False
    v = value.lower()
    if v.startswith("0"):
        return False
    if v in ["none", "n/a", "unknown"]:
        return False
    return True

def normalize_model(value):
    """Normalize model strings for comparison."""
    if not value:
        return ""
    value = value.upper().strip()
    # Remove brand words
    value = re.sub(r'\bLENOVO\b', '', value)
    value = re.sub(r'\bTHINKPAD\b', '', value)
    # Normalize generation wording: "5TH GEN" -> "GEN 5"
    value = re.sub(r'\b(\d+)(ST|ND|RD|TH)\s+GEN\b', r'GEN \1', value)
    # Collapse spaces
    value = re.sub(r'\s+', ' ', value).strip()
    return value

def normalize_compact(value):
    """Lowercase, remove spaces for compact matching."""
    return re.sub(r"\s+", "", value.lower())

def classify_model_priority(model):
    """
    Priority tiers:
      1 = letters + numbers + extra word(s)   e.g. X1 Carbon, T14 Gen 2, Yoga 11e
      2 = letters + numbers only              e.g. X1, T480, E14
      3 = numbers only                        e.g. 25, 300, 390
      4 = everything else / fallback
    """
    norm = normalize_model(model)
    has_letters = bool(re.search(r'[A-Z]', norm))
    has_digits = bool(re.search(r'\d', norm))
    tokens = norm.split()

    if re.fullmatch(r'\d+', norm):
        return 3
    if has_letters and has_digits and len(tokens) >= 2:
        return 1
    if has_letters and has_digits:
        return 2
    return 4

def build_model_index(canon_models):
    """Build priority groups for canonical models."""
    groups = {1: [], 2: [], 3: [], 4: []}
    for model in canon_models:
        norm = normalize_model(model)
        compact = normalize_compact(model)
        priority = classify_model_priority(model)
        groups[priority].append((compact, norm, model))
    # longest first within each tier
    for priority in groups:
        groups[priority].sort(key=lambda x: len(x[0]), reverse=True)
    return groups

def find_best_model_match(text, model_groups):
    """Return the best canonical model match for a text string."""
    if not text:
        return None
    text_norm = normalize_model(text)
    text_compact = normalize_compact(text)

    # -------------------------
    # Tier 1: letters+digits+words
    # -------------------------
    for model_compact, _norm, canonical_model in model_groups[1]:
        if model_compact in text_compact:
            return canonical_model

    # -------------------------
    # Tier 2: letters+digits
    # -------------------------
    for model_compact, _norm, canonical_model in model_groups[2]:
        if model_compact in text_compact:
            return canonical_model

    # -------------------------
    # Tier 3: numeric-only
    # Only match if "ThinkPad <number>" appears
    # -------------------------
    for _compact, model_norm, canonical_model in model_groups[3]:
        pattern = rf'\b{re.escape(model_norm)}\b'
        if re.search(pattern, text_norm):
            return canonical_model

    # -------------------------
    # Tier 4: fallback
    # -------------------------
    for model_compact, _norm, canonical_model in model_groups[4]:
        if model_compact in text_compact:
            return canonical_model

    return None

def should_prefer_title_model(aspect_model, title_model):
    """
    Decide if title-derived model should override aspect model.
    Prefer title if it is longer/more descriptive or higher priority.
    """
    aspect_priority = classify_model_priority(aspect_model) if aspect_model else 0
    title_priority = classify_model_priority(title_model) if title_model else 0

    if title_priority < aspect_priority:
        return True
    if title_priority == aspect_priority:
        return len(title_model) > len(aspect_model)
    return False

def save_seller_info(listing, item):
    # -------------------------
    # Save seller info
    # -------------------------
    seller = item.get("seller", {})

    listing.seller_username = seller.get("username")
    listing.seller_feedback_score = seller.get("feedbackScore")

    feedback_percent = seller.get("feedbackPercentage")
    if feedback_percent not in (None, ""):
        try:
            listing.seller_feedback_percent = Decimal(str(feedback_percent))
        except (InvalidOperation, ValueError):
            listing.seller_feedback_percent = None
    else:
        listing.seller_feedback_percent = None

# -------------------------
# Main function
# -------------------------
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

        save_seller_info(listing, item)

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
        # Apply FIELD_MAP
        # -------------------------
        for field, config in FIELD_MAP.items():
            for key in config["keys"]:
                if key not in aspects:
                    continue
                value = aspects[key]

                setattr(listing, field, value)
                break  # stop lower-priority keys

        updated += 1

    db.session.commit()
    print(f"Updated {updated} temp_details.")


"""
if field in ["ram", "storage"] and not valid_capacity(value):
                    continue
                if field == "storage_type":
                    value = clean_storage_type(value)
    do something with this in pipeline

"""


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

