from app.extensions import db
from app.ebay_models import Product, Listing
from datetime import datetime, timezone


def mark_missing_as_sold(current_ids):

    active_listings = Listing.query.filter_by(status="ACTIVE").all()

    for listing in active_listings:
        if listing.ebay_item_id not in current_ids:
            listing.status = "SOLD"
            listing.sold_at = datetime.now(timezone.utc)

def upsert_listings(items):

    current_ids = set()

    for item in items:
        item_id = item["itemId"]
        current_ids.add(item_id)

        # --- Determine Product ---
        # Option 1: parse from title (simple)
        # You could also extract from eBay item specifics
        title_lower = item["title"].lower()
        if "t14s" in title_lower:
            model_name = "ThinkPad T14s"
        elif "t14" in title_lower:
            model_name = "ThinkPad T14"
        else:
            model_name = "Other"

        # --- Find or create Product ---
        product = Product.query.filter_by(model_name=model_name).first()
        if not product:
            product = Product(model_name=model_name)
            db.session.add(product)
            db.session.flush()  # get product.id without committing yet

        # --- Upsert Listing ---

        listing = Listing.query.filter_by(ebay_item_id=item_id).first()

        listing_type = ",".join(item.get("buyingOptions", []))
        price = float(item["price"]["value"])

        if not listing:
            listing = Listing(
                product_id=product.id,
                ebay_item_id=item_id,
                title=item["title"],
                price=price,
                currency=item["price"]["currency"],
                listing_type=listing_type,
                status="ACTIVE",
                first_seen=datetime.now(timezone.utc),
                last_seen=datetime.now(timezone.utc)
            )
            db.session.add(listing)
        else:
            listing.price = price
            listing.listing_type = listing_type
            listing.last_seen = datetime.now(timezone.utc)
            listing.condition = item.get("condition", None)
            listing.url = item.get("itemWebUrl", None)

    mark_missing_as_sold(current_ids)

    db.session.commit()


def update_final_sale_price(listing, final_price):
    listing.price = float(final_price)
    listing.status = "SOLD"
    listing.sold_at = datetime.now(timezone.utc)