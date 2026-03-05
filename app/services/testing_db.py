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
    # MODEL
    "model": {
        "keys": [
            "Model", 
            "Modell", 
            "MPN", 
            "Herstellernummer"
        ],
        "type": "relation"
    },
    # CPU
    "cpu": {
        "keys": [
            "Processor",
            "Prozessor",
            "PROCESSOR / CPU",
            "CPU",
            "CPU-Typ",
            "CPU-Modell",
            "Processor Model"
        ]
    },
    # CPU Speed
    "cpu_freq": {
        "keys":[
            "Processor Speed",
            "Prozessorgeschwindigkeit"
        ]
    },
    # RAM
    "ram": {
        "keys": [
            "Total Memory",
            "RAM Size",
            "Arbeitsspeicher",
            "Arbeitsspeichergröße",
            "RAM / MEMORY",
            "Ram:",
            "Memory",
            "RAM",
            "Memory+Storage"
        ]
    },
    # Storage
    "storage": {
        "keys": [
            "HD Size",
            "SSD Capacity",
            "Hard Drive Capacity",
            "Storage Capacity",
            "Festplattenkapazität",
            "SSD-Festplattenkapazität",
            "Festplatte",
            "Kapazität SSD",
            "Hard Drive",
            "SSD / STORAGE",
            "SSD:",
            "STORAGE",
            "Memory+Storage",
            "Storage",
            "SSD",
            "Hard Drive Capacity GB"
        ]
    },
    # Storage Type
    "storage_type": {
        "keys": [
            "Drive Type",
            "Storage Type",
            "Laufwerktyp",
            "Festplattentyp",
            "Festplatten-Typ",
            "Art der speicherung von"
        ]
    },
    # Screen / Display
    "screen_size": {
        "keys": [
            "Screen Size",
            "Bildschirmgröße"
        ]
    },
    # Display Resolution
    "display": {
        "keys": ["Maximum Resolution",
            "Display Resolution",
            "Auflösung",
            "Maximale Auflösung",
            "Displayauflösung"
        ]
    },
    # GPU
    "gpu": {
        "keys": [
            "Video Adapter",
            "GPU",
            "Grafikkarte",
            "Grafikprozessor",
            "Graphics",
            "Grafikprozessortyp",
            "Graphics Processing Type"
        ]
    },
    # OS
    "os": {
        "keys": [
            "OS Installed",
            "Operating System",
            "Betriebssystem",
            "Operating System Edition"
        ]
    }
}

# flatten FIELD_MAP for fa
FIELD_LOOKUP = {}

for field, config in FIELD_MAP.items():
    for key in config["keys"]:
        FIELD_LOOKUP.setdefault(key, field) # preserve priority

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

    existing_models = {m.slug: m for m in Model.query.all()}

    with open(filepath, "r", encoding="utf-8") as f:
        items = json.load(f)

    updated = 0

    for item in items:

        item_id = item.get("itemId")
        if not item_id:
            continue
        
        existing_listings = {l.ebay_item_id: l for l in Listing.query.all()}
        listing = existing_listings.get(item_id)
        if not listing:
            continue

        aspects = {
            a.get("name"): a.get("value")
            for a in item.get("localizedAspects", [])
            if a.get("name") and a.get("value")
        }

        for name, value in aspects.items():

            field = FIELD_LOOKUP.get(name)

            if field == "model":

                model_name = value.strip()
                model_slug = slugify(model_name)

                model = existing_models.get(model_slug)

                if not model:
                    model = Model(name=model_name, slug=model_slug)
                    db.session.add(model)
                    existing_models[model_slug] = model

                listing.model = model

            elif field:
                setattr(listing, field, value)

        updated += 1

    db.session.commit()
    print(f"Updated {updated} listings with detailed specs.")



