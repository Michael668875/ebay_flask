from pathlib import Path
from decimal import Decimal
from datetime import datetime
from app.extensions import db
from app.models import TempSummaries, TempDetails
import re

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
            "SSD Capacity",
            "SSD / STORAGE",
            "SSD",
            "SSD:",
            "Storage Capacity",
            "Hard Drive Capacity",
            "HD Size",
            "Festplattenkapazität",
            "SSD-Festplattenkapazität",
            "Festplatte",
            "Kapazität SSD",
            "Hard Drive",
            "STORAGE",
            "Memory+Storage",
            "Storage",
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

