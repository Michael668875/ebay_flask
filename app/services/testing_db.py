from pathlib import Path
import json
from decimal import Decimal
from datetime import datetime, timezone
from app.extensions import db
from app.models import Listing, PriceHistory, Model
from slugify import slugify

BASE_DIR = Path(__file__).resolve().parent.parent.parent
LOG_PATH = BASE_DIR / "get_thinkpads_log.txt"
DETAIL_PATH = BASE_DIR / "get_details_log.txt"
FIELD_MAP = {
    # CPU
    "Processor": "cpu",
    "Prozessor": "cpu",
    # CPU Speed
    "Processor Speed": "cpu_freq",
    "Prozessorgeschwindigkeit": "cpu_freq",
    # RAM
    "Total Memory": "ram",
    "RAM Size": "ram",
    "Arbeitsspeicher": "ram",
    # Storage
    "HD Size": "storage",
    "SSD Capacity": "storage",
    "Hard Drive Capacity": "storage",
    "Festplattenkapazität": "storage",
    # Storage Type
    "Drive Type": "storage_type",
    "Laufwerktyp": "storage_type",
    "Storage Type": "storage_type",
    # Screen / Display
    "Screen Size": "screen_size",
    "Bildschirmgröße": "screen_size",
    # Display Resolution
    "Maximum Resolution": "display",
    "Display Resolution": "display",
    "Auflösung": "display",
    # GPU
    "Video Adapter": "gpu",
    "GPU": "gpu",
    "Grafikkarte": "gpu",
    # OS
    "OS Installed": "os",
    "Operating System": "os",
    "Betriebssystem": "os",
}


""" CHANGE TO A PRIORITY FIELD MAP LIKE THIS:
FIELD_PRIORITY = {
    "model": ["model", "mpn"],
    "cpu": ["Processor", "Prozessor"],
    # ...
}

Then:

for field, keys in FIELD_PRIORITY.items():
    for key in keys:
        if key in specs:
            setattr(product, field, specs[key])
            break

"""



# insert only item summaries into db

def insert_summaries_from_log(filepath=LOG_PATH):
    """
    Inserts listing-level data from saved summary JSON.
    Creates placeholder listings with correct price/currency.
    Updates currency for existing listings.
    """

    with open(filepath, "r", encoding="utf-8") as f:
        items = json.load(f)

    inserted = 0
    updated = 0

    for item in items:
        item_id = item.get("itemId")
        if not item_id:
            continue

        price_info = item.get("price", {})
        price_value = price_info.get("value")
        currency = price_info.get("currency")
        category_id = item.get("leafCategoryIds", [None])[0]

        listing = Listing.query.filter_by(ebay_item_id=item_id).first()

        if listing:
            # Update currency if it changed
            if currency and listing.currency != currency:
                listing.currency = currency
                updated += 1
            # Update category if missing
            if category_id and not listing.category_id:
                listing.category_id = category_id
            continue  # skip creating a new listing

        # Create new listing with category
        listing = Listing(
            ebay_item_id=item_id,
            title=item.get("title"),
            price=Decimal(str(price_value)) if price_value else None,
            currency=currency,
            marketplace=item.get("marketplace_id"),
            condition=item.get("condition"),
            listing_type=",".join(item.get("buyingOptions", [])),
            item_url=item.get("itemWebUrl"),
            category_id=category_id  # <-- add here
        )
        db.session.add(listing)
        db.session.flush()

        # Insert initial price snapshot
        if price_value:
            price_entry = PriceHistory(
                listing_id=listing.id,
                price=Decimal(str(price_value)),
                currency=currency,
                recorded_at=datetime.now(timezone.utc)
            )
            db.session.add(price_entry)

        inserted += 1

    db.session.commit()
    print(f"Inserted {inserted} new listings, updated {updated} currencies.")



def insert_details_from_log(filepath=DETAIL_PATH):
    """
    Enrich existing listings using detailed item JSON.
    Assumes summaries were inserted first.
    """

    existing_models = {
            m.slug: m
            for m in Model.query.all()
        }

    with open(filepath, "r", encoding="utf-8") as f:
        items = json.load(f)

    updated = 0

    for item in items:

        item_id = item.get("itemId")
        if not item_id:
            continue

        listing = Listing.query.filter_by(ebay_item_id=item_id).first()
        if not listing:
            continue

        # Parse aspects
        for aspect in item.get("localizedAspects", []):
            name = aspect.get("name")
            value = aspect.get("value")

            # Handle mapped fields
            field_name = FIELD_MAP.get(name)
            if field_name:
                setattr(listing, field_name, value)

            # Handle model (MPN)
            if name in ("MPN", "Herstellernummer", "Model"):
                model_name = value.strip()
                model_slug = slugify(model_name)

                model = existing_models.get(model_slug)

                if not model:
                    model = Model(name=model_name, slug=model_slug)
                    db.session.add(model)
                    existing_models[model_slug] = model

                listing.model = model

        updated += 1

    db.session.commit()
    print(f"Updated {updated} listings with detailed specs.")