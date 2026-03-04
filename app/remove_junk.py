# THIS IS A TEMPORARY FILE TO REMOVE JUNK LISTINGS SUCH AS BATTERIES, STANDS, CHARGERS ETC
# AND REMOVE LISTINGS NOT IN CATEGORY 177

from app import create_app
from app.extensions import db
from app.models import Model, Listing

app = create_app()

def is_real_laptop(product_dict: dict) -> bool:
    """
    Returns True if this product looks like a real laptop.
    Requires:
    - model_name must exist
    - At least one of cpu, ram, or storage must be filled
    """
    # model_name must exist
    if not product_dict.get("model"):
        return False

    # At least one spec
    if product_dict.get("cpu") or product_dict.get("ram") or product_dict.get("storage"):
        return True

    # Otherwise, treat as junk
    return False

with app.app_context():

    deleted_items = 0
    deleted_listings = 0

    # Fetch all products
    listings = Listing.query.all()

    for listing in listings:
        item_specifics = {
            "model": listing.model,
            "processor": listing.cpu,
            "ram": listing.ram,
            "storage": listing.storage,
        }

        """if not is_real_laptop(item_specifics):
            print(f"Junk detected: model name: {listing.model} cpu: {listing.cpu} ram: {listing.ram} storage: {listing.storage}") # uncomment db.session.delete(product) when you’re confident.
            db.session.delete(listing)
            deleted_items += 1"""

        if listing.category_id != "177":
            print(f"Removing non-177 listing: {listing.title} (Category: {listing.category_id})")
            db.session.delete(listing)
            deleted_listings +=1

    db.session.commit()

    """# remove orphaned products
    orphaned_product = Listing.query.all()

    for item in orphaned_product:
        if not item.model:
            print(f"Removing orphaned product: {listing.model}")
            db.session.delete(item)
            deleted_products += 1"""

    db.session.commit()
    print(f"\nDeleted {deleted_items} products")
    print(f"Deleted {deleted_listings} junk products (and their listings).")