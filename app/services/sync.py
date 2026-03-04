from app.extensions import db
from app.models import Product, Listing, PriceHistory
from datetime import datetime, timezone, timedelta
import json
from pathlib import Path
from slugify import slugify
from sqlalchemy.orm import Session
from app.models import CPU, RAM, Storage
from decimal import Decimal, ROUND_HALF_UP
import re


def ensure_product_slug(product: Product):
    """
    Generate a slug for a product if it doesn't have one.
    """
    if product.slug:
        return  # already has slug

    session: Session = db.session
    base_slug = slugify(f"thinkpad {product.model_name or 'unknown'}")
    slug = base_slug
    counter = 1

    # ensure uniqueness
    while session.query(Product).filter_by(slug=slug).first():
        slug = f"{base_slug}-{counter}"
        counter += 1

    product.slug = slug

def mark_missing_as_sold():
    now = datetime.now(timezone.utc)

    # Only consider listings not seen recently
    threshold = now - timedelta(hours=24)

    stale_listings = Listing.query.filter(
        Listing.status == "ACTIVE",
        Listing.last_seen < threshold
    ).all()

    for listing in stale_listings:
        listing.status = "SOLD"
        listing.sold_at = now
        listing.last_updated = now

    db.session.commit()


def save_thinkpads(items, context, batch_size=50):
    processed_count = 0

    for item in items:
        try:
            process_item_summary(item, context)
            processed_count += 1

            if processed_count % batch_size == 0:
                db.session.commit()

        except Exception as e:
            handle_failed_item(item, e)

    db.session.commit()
    mark_missing_as_sold()



def build_context(items):
    now = datetime.now(timezone.utc)

    ebay_ids = [item["itemId"] for item in items]
    existing = Listing.query.filter(
        Listing.ebay_item_id.in_(ebay_ids)
    ).all()

    listing_lookup = {l.ebay_item_id: l for l in existing}

    return {
        "now": now,
        "listing_lookup": listing_lookup,
    }

def extract_model_from_item(item):
    # Try localized aspects first
    for aspect in item.get("localizedAspects", []):
        if aspect.get("name") in ("Model", "Modell"):
            return aspect.get("value")
    # Fallback: parse from title
    title = item.get("title", "")
    match = re.search(r"(ThinkPad\s+[A-Z0-9]+)", title)
    if match:
        return match.group(1)
    return None

def process_item_summary(item, context):
    listing_lookup = context["listing_lookup"]
    now = context["now"]

    item_id = item.get("itemId")
    if not item_id:
        return

    listing = listing_lookup.get(item_id)

    # Extract model name from the title as fallback, or use Unknown
    model_name = extract_model_from_item(item) or "Unknown"

    # Find existing Product by model name, or create new
    product = Product.query.filter_by(model_name=model_name).first()
    if not product:
        product = Product(model_name=model_name)
        db.session.add(product)
        db.session.flush()

    # Now create/update Listing
    get_or_create_or_update_listing(item, product, context)

def get_or_create_or_update_listing(item, product, context):
    listing_lookup = context["listing_lookup"]
    now = context["now"]

    listing = listing_lookup.get(item["itemId"])

    price = extract_price(item)
    currency = item["price"]["currency"]
    condition = item.get("condition", "Unknown")
    listing_type = ",".join(item.get("buyingOptions", []))
    url = item.get("itemWebUrl")
    marketplace = item.get("marketplace_id")

    if not marketplace:
        raise ValueError(f"Missing marketplace_id for {item['itemId']}")

    if not listing:
        listing = create_listing(
            item, product, price, currency,
            listing_type, url, marketplace,
            condition, now
        )
        listing_lookup[item["itemId"]] = listing
    else:
        update_listing(listing, price, currency, condition, now)

def extract_price(item):
    price_str = item["price"]["value"]
    return Decimal(price_str).quantize(
        Decimal("0.01"),
        rounding=ROUND_HALF_UP
    )

def create_listing(item, product, price, currency,
                   listing_type, url, marketplace,
                   condition, now):

    listing = Listing(
        product_id=product.id,
        ebay_item_id=item["itemId"],
        title=item["title"],
        price=price,
        currency=currency,
        listing_type=listing_type,
        url=url,
        marketplace=marketplace,
        condition=condition,
        status="ACTIVE",
        first_seen=now,
        last_seen=now,
        last_updated=now,
    )

    db.session.add(listing)
    db.session.flush()

    db.session.add(
        PriceHistory(
            listing_id=listing.id,
            price=price,
            currency=currency,
            checked_at=now,
        )
    )

    return listing

def update_listing(listing, new_price, currency, condition, now):
    listing.last_seen = now
    listing.condition = condition

    if listing.price != new_price:
        listing.price = new_price
        listing.last_updated = now

        db.session.add(
            PriceHistory(
                listing_id=listing.id,
                price=new_price,
                currency=currency,
                checked_at=now,
            )
        )

def handle_failed_item(item, error):
    db.session.rollback()

    fail_log_file = Path(__file__).parent / "failed_items.jsonl"

    with fail_log_file.open("a", encoding="utf-8") as f:
        f.write(json.dumps({
            "item": item,
            "error": str(error)
        }) + "\n")

# get item specifics from detailed item api
ASPECT_NAME_MAP = {
    'Model': 'model',
    'Modell': 'model',
    'Processor': 'cpu',
    'Prozessor': 'cpu',  # German
    'RAM Size': 'ram',
    'Arbeitsspeicher': 'ram',
    'SSD Capacity': 'storage',
    'Speicherkapazität': 'storage',    
}
def extract_specs(localized_aspects):
    specs = {}

    # Convert list of dicts to a lookup
    aspect_lookup = {}
    for aspect in localized_aspects:
        field_name = ASPECT_NAME_MAP.get(aspect['name'])
        if field_name:
            specs[field_name] = aspect['value']

    return specs


def get_or_create_cpu(name):
    if not name:
        return None
    cpu = CPU.query.filter_by(name=name).first()
    if not cpu:
        cpu = CPU(name=name)
        db.session.add(cpu)
        db.session.flush()
    return cpu

def get_or_create_ram(size):
    if not size:
        return None
    ram = RAM.query.filter_by(size=size).first()
    if not ram:
        ram = RAM(size=size)
        db.session.add(ram)
        db.session.flush()
    return ram

def get_or_create_storage(size):
    if not size:
        return None
    storage = Storage.query.filter_by(size=size).first()
    if not storage:
        storage = Storage(size=size)
        db.session.add(storage)
        db.session.flush()
    return storage

def update_product_with_specs(product, specs):
    cpu_obj = get_or_create_cpu(specs.get('cpu'))
    ram_obj = get_or_create_ram(specs.get('ram'))
    storage_obj = get_or_create_storage(specs.get('storage'))

    # Assign CPU/RAM/Storage if available
    if cpu_obj:
        product.cpu = cpu_obj.name
    if ram_obj:
        product.ram = ram_obj.size
    if storage_obj:
        product.storage = storage_obj.size
    if specs.get('storage_type'):
        product.storage_type = specs['storage_type']

    # Assign model name
    if specs.get('model'):
        product.model_name = specs['model']    # Optional: store GPU / screen size as custom fields if needed
    # e.g., product.gpu = specs.get('gpu')

def save_thinkpads_detailed(detailed_items, context):
    fail_log_file = Path(__file__).parent / "failed_detailed_items.jsonl"

    listing_lookup = context["listing_lookup"]

    for item in detailed_items:
        try:
            item_id = item.get("itemId")
            if not item_id:
                continue

            listing = listing_lookup.get(item_id)
            if not listing:
                print(f"No listing found for {item_id}")
                continue

            product = listing.product
            if not product:
                print(f"No product attached to listing {item_id}")
                continue

            # Extract specs from localizedAspects
            specs = extract_specs(item.get('localizedAspects', []))

            # Update Product with normalized specs
            update_product_with_specs(product, specs)
            db.session.commit()

        except Exception as e:
            db.session.rollback()
            with fail_log_file.open("a", encoding="utf-8") as f:
                f.write(json.dumps({"item": item, "error": str(e)}) + "\n")
            print(f"Failed detailed item {item.get('itemId')}: {e}")

    


    

"""import json

with open("get_thinkpads_log.json", "r", encoding="utf-8") as f:
    data = json.load(f)

for item in data:
    print(item.get("title"))"""

#get details from the above file

"""for item in data:
    aspects = item.get("localizedAspects", [])
    for aspect in aspects:
        if aspect.get("name") == "Model":
            print(aspect.get("value"))"""