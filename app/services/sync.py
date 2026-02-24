from app.extensions import db
from app.models import Product, Listing, PriceHistory
from datetime import datetime, timezone
from app.services.model_parser import is_real_laptop
import json
from pathlib import Path


def mark_missing_as_sold(current_ids):
    """Mark ACTIVE listings not seen in the latest fetch as SOLD."""
    now = datetime.now(timezone.utc)
    active_listing = Listing.query.filter_by(status="ACTIVE").all()
    for listing in active_listing:
        if listing.ebay_item_id not in current_ids:
            listing.status = "SOLD"
            listing.sold_at = now
            listing.last_updated = now
    db.session.commit()


def parse_product_details(title: str):
    """Fallback parser if eBay item specifics are missing."""
    words = title.split()
    model = " ".join(words[:3]) if len(words) >= 3 else title
    title_lower = title.lower()

    cpu = "i7" if "i7" in title_lower else "i5" if "i5" in title_lower else "Unknown"
    ram = "16GB" if "16gb" in title_lower else "8GB" if "8gb" in title_lower else "Unknown"
    storage = "512GB SSD" if "512gb" in title_lower else "256GB SSD" if "256gb" in title_lower else "Unknown"

    return model, cpu, ram, storage

def extract_aspects(item):
    """
    Extract model, cpu, ram, and storage from eBay Browse API localizedAspects.
    Returns a dict with keys: model, cpu, ram, storage
    """
    aspects_list = item.get("localizedAspects", [])

    # Convert list of {"name": "...", "value": "..."} to dict
    aspects = {a["name"].lower(): a["value"] for a in aspects_list}

    return {
        "model": aspects.get("model"),
        "cpu": aspects.get("processor"),
        "ram": aspects.get("ram size") or aspects.get("ram for multitasking"),
        "storage": aspects.get("ssd capacity") or aspects.get("hard drive capacity"),
    }

def save_thinkpads(items, app, batch_size=50, fail_log_path="failed_itmes.jsonl"):
    """
    Save ThinkPad items into Product, Listing, and PriceHistory.
    Handles new listings, updates, price history, and marking missing listings as SOLD.
    """
    fail_log_file = Path(fail_log_path)
    with app.app_context():
        now = datetime.now(timezone.utc)
        current_ids = set()
        ebay_ids = [item["itemId"] for item in items]
        model_names = [extract_aspects(item)["model"] for item in items]
        existing_listings = Listing.query.filter(Listing.ebay_item_id.in_(ebay_ids)).all()
        existing_products = Product.query.filter(Product.model_name.in_(model_names)).all()
        listing_lookup = {l.ebay_item_id: l for l in existing_listings}
        product_lookup = {p.model_name: p for p in existing_products}

        processed_count = 0 # track items to commit in batches

        for item in items:
            try:
                ebay_id = item["itemId"]
                title = item["title"]
                price = float(item["price"]["value"])
                currency = item["price"]["currency"]
                current_ids.add(ebay_id)

                # get category id
                category_id = item["categories"][0]["categoryId"] if item.get("categories") else None

                # Condition can be a dict or string
                condition_data = item.get("condition")
                condition = condition_data.get("conditionDisplayName") if isinstance(condition_data, dict) else condition_data

                # Parse eBay item specifics
                aspects = extract_aspects(item)

                model_name = aspects["model"]
                cpu = aspects["cpu"]
                ram = aspects["ram"]
                storage = aspects["storage"]

                # listing is your item from eBay API
                item_specifics = {
                    "model": model_name,
                    "cpu": cpu,
                    "ram": ram,
                    "storage": storage,
                }

                if not is_real_laptop(item_specifics):
                    continue # Skip batteries, chargers, accessories etc

                # Fallback to title parsing if any missing
                if not cpu or not ram or not storage:
                    model_name_fallback, cpu_fallback, ram_fallback, storage_fallback = parse_product_details(title)
                    model_name = model_name or model_name_fallback
                    cpu = cpu or cpu_fallback
                    ram = ram or ram_fallback
                    storage = storage or storage_fallback

                # --- Get or create Product ---
                product = product_lookup.get(model_name)
                if not product:
                    product = Product(model_name=model_name, cpu=cpu, ram=ram, storage=storage)
                    db.session.add(product)
                    db.session.flush()  # product.id now available
                    product_lookup[model_name] = product

                # --- Get or create Listing ---
                listing = listing_lookup.get(ebay_id)
                listing_type = ",".join(item.get("buyingOptions", []))
                url = item.get("itemWebUrl")
                listing.url = url
                listing.last_seen = now

                if listing:
                    # Update if anything changed
                    changed = False                              
                    price_changed = listing.price != price

                    if price_changed: # separate price changes from other attributes for PriceHistory
                        listing.price = price

                    # Check other fields (excluding price)
                    for attr, value in [
                        ("title", title),
                        ("condition", condition),
                        ("listing_type", listing_type),
                        ("category_id", category_id),
                    ]:
                        if getattr(listing, attr) != value:
                            setattr(listing, attr, value)
                            changed = True

                    if changed or price_changed:
                        listing.last_updated = now
                        db.session.add(listing)

                    if price_changed:
                        db.session.add(
                            PriceHistory(
                                listing_id=listing.id,
                                price=price,
                                currency=currency,
                                checked_at=now
                            )
                        )
                else:
                    # New listing
                    listing = Listing(
                        product_id=product.id,
                        ebay_item_id=ebay_id,
                        category_id=category_id,
                        title=title,
                        price=price,
                        currency=currency,
                        condition=condition,
                        listing_type=listing_type,
                        url=url,
                        status="ACTIVE",
                        first_seen=now,
                        last_seen=now,
                        last_updated=now
                    )
                    db.session.add(listing)
                    db.session.flush()  # listing.id available

                    # Initial price history
                    db.session.add(PriceHistory(listing_id=listing.id, price=price, currency=currency, checked_at=now))
                    listing_lookup[ebay_id] = listing # add this so later items can reference

                    processed_count += 1

                    #--- Commit in batches ---
                    if processed_count % batch_size == 0:
                        # Commit everything
                        db.session.commit()

            except Exception as e:
                db.session.rollback()

                # set number of times to retry
                retry_count = item.get("retry_count", 0) + 1
                log_entry = {
                    "item": item,
                    "error": str(e),
                    "retry_count": retry_count
                }

                # Log failed item to a file in JSON Lines format
                with fail_log_file.open("a", encoding="utf-8") as f:
                    log_entry = {"item": item, "error": str(e)}
                    f.write(json.dumps(log_entry) + "\n")
                print(f"Failed to save item {item.get('itemId')}: {e}")

        # commit any remaining items after the loop
        db.session.commit()

        # Mark missing listings as SOLD
        mark_missing_as_sold(current_ids)

        