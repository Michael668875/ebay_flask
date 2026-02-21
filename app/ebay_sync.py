from app.extensions import db
from app.ebay_models import Product, Listing, PriceHistory
from datetime import datetime, timezone

def mark_missing_as_sold(current_ids):
    """Mark ACTIVE listings not seen in the latest fetch as SOLD."""
    now = datetime.now(timezone.utc)
    for listing in Listing.query.filter_by(status="ACTIVE").all():
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


def save_thinkpads(items, app):
    """
    Save ThinkPad items into Product, Listing, and PriceHistory.
    Handles new listings, updates, price history, and marking missing listings as SOLD.
    """
    with app.app_context():
        now = datetime.now(timezone.utc)
        current_ids = set()

        for item in items:
            ebay_id = item["itemId"]
            title = item["title"]
            price = float(item["price"]["value"])
            currency = item["price"]["currency"]
            current_ids.add(ebay_id)

            # Condition can be a dict or string
            condition_data = item.get("condition")
            condition = condition_data.get("conditionDisplayName") if isinstance(condition_data, dict) else condition_data

            # Parse eBay item specifics
            specifics = item.get("itemSpecifics", {}).get("nameValues", [])
            specifics_dict = {s["name"].lower(): s["value"][0] for s in specifics if s.get("value")}
            model_name = specifics_dict.get("model") or " ".join(title.split()[:3])
            cpu = specifics_dict.get("processor")
            ram = specifics_dict.get("ram")
            storage = specifics_dict.get("storage capacity")

            # Fallback to title parsing if any missing
            if not cpu or not ram or not storage:
                model_name_fallback, cpu_fallback, ram_fallback, storage_fallback = parse_product_details(title)
                model_name = model_name or model_name_fallback
                cpu = cpu or cpu_fallback
                ram = ram or ram_fallback
                storage = storage or storage_fallback

            # --- Get or create Product ---
            product = Product.query.filter_by(model_name=model_name).first()
            if not product:
                product = Product(model_name=model_name, cpu=cpu, ram=ram, storage=storage)
                db.session.add(product)
                db.session.flush()  # product.id now available

            # --- Get or create Listing ---
            listing = Listing.query.filter_by(ebay_item_id=ebay_id).first()
            listing_type = ",".join(item.get("buyingOptions", []))
            url = item.get("itemWebUrl")

            if listing:
                # Update if anything changed
                changed = False
                for attr, value in [("price", price), ("title", title), ("condition", condition), ("listing_type", listing_type)]:
                    if getattr(listing, attr) != value:
                        setattr(listing, attr, value)
                        changed = True
                if changed:
                    listing.last_updated = now
                    db.session.add(listing)
                    # Add price history only if price changed
                    db.session.add(PriceHistory(listing_id=listing.id, price=price, currency=currency, checked_at=now))

                listing.url = url
                listing.last_seen = now

            else:
                # New listing
                listing = Listing(
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
                db.session.add(listing)
                db.session.flush()  # listing.id available

                # Initial price history
                db.session.add(PriceHistory(listing_id=listing.id, price=price, currency=currency, checked_at=now))

        # Mark missing listings as SOLD
        mark_missing_as_sold(current_ids)

        # Commit everything
        db.session.commit()