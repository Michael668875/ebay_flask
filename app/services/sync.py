from app.extensions import db
from app.models import Product, Listing, PriceHistory
from datetime import datetime, timezone, timedelta
from app.services.model_parser import parse_product_details
import json
from pathlib import Path


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

def save_thinkpads(items, app, batch_size=50):
    fail_log_file = Path(__file__).parent / "failed_items.jsonl"

    with app.app_context():
        now = datetime.now(timezone.utc)
        processed_count = 0

        # Build lookups for faster access
        ebay_ids = [item["itemId"] for item in items]
        existing_listings = Listing.query.filter(Listing.ebay_item_id.in_(ebay_ids)).all()
        listing_lookup = {l.ebay_item_id: l for l in existing_listings}

        for item in items:
            try:
                title = item["title"]
                short_desc = item.get("shortDescription", "")
                marketplace_id = item.get("marketplace_id")
                if not marketplace_id:
                    raise ValueError(f"Missing marketplace_id for item {item['itemId']}")

                # Parse all specs
                model_name, cpu, cpu_freq, ram, storage, storage_type = parse_product_details(title, short_desc)

                # --- Get or create Product ---
                product = Product.query.filter_by(model_name=model_name).first()
                if not product:
                    product = Product(model_name=model_name, cpu=cpu, cpu_freq=cpu_freq, ram=ram, storage=storage, storage_type=storage_type)
                    db.session.add(product)
                    db.session.flush()  # get product.id

                # --- Get or create/update Listing ---
                listing = listing_lookup.get(item["itemId"])
                price = float(item["price"]["value"])
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
        