from app.extensions import db
from app.models import Product, Listing, PriceHistory
from datetime import datetime, timezone, timedelta
from app.services.model_parser import parse_product_details
import json
from pathlib import Path
from slugify import slugify
from sqlalchemy.orm import Session
from app.models import ThinkPadModel, CPU, RAM, Storage
from decimal import Decimal, ROUND_HALF_UP


def get_specs():
    MODEL = [m.name for m in ThinkPadModel.query.all()]
    PROCESSOR = [c.name for c in CPU.query.all()]
    MEMORY = [r.size for r in RAM.query.all()]
    STORAGE = [s.size for s in Storage.query.all()]
    return MODEL, PROCESSOR, MEMORY, STORAGE

def ensure_product_slug(product: Product):
    """
    Generate a slug for a product if it doesn't have one.
    """
    if product.slug:
        return  # already has slug

    session: Session = db.session
    base_slug = slugify(f"thinkpad {product.model_name}")
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

"""def save_thinkpads(items, app, batch_size=50):
    fail_log_file = Path(__file__).parent / "failed_items.jsonl"

    with app.app_context():
        now = datetime.now(timezone.utc)
        processed_count = 0

        # Build lookups for faster access
        ebay_ids = [item["itemId"] for item in items]
        existing_listings = Listing.query.filter(Listing.ebay_item_id.in_(ebay_ids)).all()
        listing_lookup = {l.ebay_item_id: l for l in existing_listings}

        MODEL, PROCESSOR, MEMORY, STORAGE = get_specs()


        for item in items:
            try:
                title = item["title"]
                short_desc = item.get("shortDescription", "")
                marketplace_id = item.get("marketplace_id")
                if not marketplace_id:
                    raise ValueError(f"Missing marketplace_id for item {item['itemId']}")

                # Parse all specs
                model_name, cpu, cpu_freq, ram, storage, storage_type = parse_product_details(title, short_desc, MODEL, PROCESSOR, MEMORY, STORAGE)

                # --- Get or create Product ---
                product = Product.query.filter_by(model_name=model_name).first()
                
                if not product:
                    product = Product(model_name=model_name, cpu=cpu, cpu_freq=cpu_freq, ram=ram, storage=storage, storage_type=storage_type)
                    db.session.add(product)
                    ensure_product_slug(product)
                    db.session.flush()  # get product.id
                    
                # --- Get or create/update Listing ---
                listing = listing_lookup.get(item["itemId"])
                # Assume item is the eBay API listing JSON
                price_str = item["price"]["value"]   # e.g. "258.92" or "258.9166667"

                # Convert to Decimal and round to 2 decimal places
                price = Decimal(price_str).quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)

                currency = item["price"]["currency"]
                condition = item.get("condition", "Unknown")
                listing_type = ",".join(item.get("buyingOptions", []))
                url = item.get("itemWebUrl")
                if not listing:
                    listing = Listing(
                        product_id=product.id,
                        ebay_item_id=item["itemId"],
                        title=title,
                        price=price,
                        currency=currency,
                        listing_type=listing_type,
                        url=url,
                        marketplace=marketplace_id,
                        condition=condition,
                        status="ACTIVE",
                        first_seen=now,
                        last_seen=now,
                        last_updated=now
                    )
                    db.session.add(listing)
                    db.session.flush()
                    # Initial price history
                    db.session.add(PriceHistory(listing_id=listing.id, price=listing.price, currency=listing.currency, checked_at=now))
                    listing_lookup[item["itemId"]] = listing
                else:
                    listing.last_seen = now
                    listing.condition = condition

                    if listing.price != price:
                        listing.price = price
                        listing.last_updated = now
                        db.session.add(
                            PriceHistory(
                                listing_id=listing.id,
                                price=price,
                                currency=currency,
                                checked_at=now
                            )
                        )

                processed_count += 1
                if processed_count % batch_size == 0:
                    db.session.commit()

            except Exception as e:
                db.session.rollback()
                with fail_log_file.open("a", encoding="utf-8") as f:
                    f.write(json.dumps({"item": item, "error": str(e)}) + "\n")
                #print(f"Failed item {item['itemId']}: {e}")

        # commit remaining items
        db.session.commit()
        mark_missing_as_sold()
"""        
#################################################

def save_thinkpads(items, app, batch_size=50):
    with app.app_context():
        context = build_context(items)
        processed_count = 0

        for item in items:
            try:
                process_item(item, context)
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

    MODEL, PROCESSOR, MEMORY, STORAGE = get_specs()

    return {
        "now": now,
        "listing_lookup": listing_lookup,
        "MODEL": MODEL,
        "PROCESSOR": PROCESSOR,
        "MEMORY": MEMORY,
        "STORAGE": STORAGE,
    }

def process_item(item, context):
    product = get_or_create_product(item, context)
    get_or_create_or_update_listing(item, product, context)


def get_or_create_product(item, context):
    title = item["title"]
    short_desc = item.get("shortDescription", "")

    model_name, cpu, cpu_freq, ram, storage, storage_type = parse_product_details(
        title,
        short_desc,
        context["MODEL"],
        context["PROCESSOR"],
        context["MEMORY"],
        context["STORAGE"],
    )

    product = Product.query.filter_by(model_name=model_name).first()

    if not product:
        product = Product(
            model_name=model_name,
            cpu=cpu,
            cpu_freq=cpu_freq,
            ram=ram,
            storage=storage,
            storage_type=storage_type,
        )
        db.session.add(product)
        ensure_product_slug(product)
        db.session.flush()

    return product

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

