from app.extensions import db
from app.ebay_models import Product, Listing, PriceHistory
from datetime import datetime, timezone

def mark_missing_as_sold(current_ids):
    now = datetime.now(timezone.utc)
    active_listings = Listing.query.filter_by(status="ACTIVE").all()
    for listing in active_listings:
        if listing.status == "ACTIVE" and listing.ebay_item_id not in current_ids:
            listing.status = "SOLD"
            listing.sold_at = now
            listing.last_updated = now
    db.session.commit()

def parse_product_details(title: str):
    """
    Fallback parser if itemSpecifics are missing.
    Tries to extract model, CPU, RAM, storage from title.
    """
    model = " ".join(title.split()[0:3])  # crude first 3 words as model
    cpu = ram = storage = "Unknown"

    title_lower = title.lower()
    if "i7" in title_lower:
        cpu = "i7"
    elif "i5" in title_lower:
        cpu = "i5"

    if "16gb" in title_lower:
        ram = "16GB"
    elif "8gb" in title_lower:
        ram = "8GB"

    if "512gb" in title_lower:
        storage = "512GB SSD"
    elif "256gb" in title_lower:
        storage = "256GB SSD"

    return model, cpu, ram, storage
    

# This handles duplicates automatically and keeps a full price history.
def save_thinkpads(items, app):
    """
    Save ThinkPad items into Product, Listing, and PriceHistory.
    Uses eBay itemSpecifics first, falls back to title parsing.
    """
    with app.app_context():
        current_ids = set()
        now = datetime.now(timezone.utc)
        for item in items:
            ebay_id = item["itemId"]
            title = item["title"]
            current_ids.add(ebay_id)

            # price info
            price = float(item["price"]["value"])
            currency = item["price"]["currency"]
            
            # condition can be a string or a dict
            condition_data = item.get("condition")
            if isinstance(condition_data, dict):
                condition = condition_data.get("conditionDisplayName")
            else:
                condition = condition_data

             # Try to parse model name, CPU, RAM, Storage from item specifics
            specifics = item.get("itemSpecifics", {}).get("nameValues", [])
            specifics_dict = {s["name"].lower(): s["value"][0] for s in specifics if s.get("value")}
            model_name = specifics_dict.get("model", title.split(",")[0])
            cpu = specifics_dict.get("processor", None)
            ram = specifics_dict.get("ram", None)
            storage = specifics_dict.get("storage capacity", None)            

            # --- Fallback to title parsing if any missing ---
            if not cpu or not ram or not storage:
                model_name_fallback, cpu_fallback, ram_fallback, storage_fallback = parse_product_details(title)
                cpu = cpu or cpu_fallback
                ram = ram or ram_fallback
                storage = storage or storage_fallback
                model_name = model_name_fallback
            else:
                # If item specifics exist, use first 3 words as model_name
                model_name = " ".join(title.split()[0:3])

            # --- Check or create Product ---
            product = Product.query.filter_by(model_name=model_name).first()
            if not product:
                product = Product(model_name=model_name, cpu=cpu, ram=ram, storage=storage)
                db.session.add(product)
                db.session.flush()  # get product.id

            # --- Check or create Listing ---
            listing = Listing.query.filter_by(ebay_item_id=ebay_id).first()

            url = item.get("itemWebUrl", None)

            listing_type = ",".join(item.get("buyingOptions", []))  # Usually ["FIXED_PRICE"]

            if listing:
                # Update listing if anything changed
                changed = False
                if listing.price != price:
                    listing.price = price
                    changed = True
                if listing.title != title:
                    listing.title = title
                    changed = True
                if listing.condition != condition:
                    listing.condition = condition
                    changed = True
                if listing.listing_type != listing_type:
                    listing.listing_type = listing_type
                    changed = True

                if changed:
                    listing.last_updated = now
                    db.session.add(listing)
                    # Add price history
                    db.session.add(PriceHistory(listing_id=listing.id, price=price, currency=currency, checked_at=now))

                listing.url = url
                listing.last_seen = now

            else:
                # New listing
                new_listing = Listing(
                    product_id=product.id,
                    ebay_item_id=ebay_id,
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
                db.session.add(new_listing)
                db.session.flush()  # get new_listing.id

                # Add initial price history
                db.session.add(PriceHistory(
                    listing_id=new_listing.id,
                    price=price,
                    currency=currency,
                    checked_at=now
                ))

    # --- Mark missing listings as SOLD ---
    mark_missing_as_sold(current_ids)
    # Commit everything
    db.session.commit()
