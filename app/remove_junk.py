# THIS IS A TEMPORARY FILE TO REMOVE JUNK LISTINGS SUCH AS BATTERIES, STANDS, CHARGERS ETC
# AND REMOVE LISTINGS NOT IN CATEGORY 177

from app import create_app
from app.extensions import db
from app.models import Product, Listing
from app.services.model_parser import is_real_laptop

app = create_app()

with app.app_context():

    deleted_products = 0
    deleted_listings = 0

    # Fetch all products
    products = Product.query.all()

    for product in products:
        item_specifics = {
            "model": product.model_name,
            "processor": product.cpu,
            "ram": product.ram,
            "storage": product.storage,
        }

        if not is_real_laptop(item_specifics):
            print(f"Junk detected: model name: {product.model_name} cpu: {product.cpu} ram: {product.ram} storage: {product.storage}") # uncomment db.session.delete(product) when you’re confident.
            db.session.delete(product)
            deleted_products += 1

    # remove listings not in category 177
    listings = Listing.query.all()

    for listing in listings:
        if listing.category_id != "177":
            print(f"Removing non-177 listing: {listing.title} (Category: {listing.category_id})")
            db.session.delete(listing)
            deleted_listings +=1

    db.session.commit()

    # remove orphaned products
    orphaned_product = Product.query.all()

    for product in orphaned_product:
        if not product.listings:
            print(f"Removing orphaned product: {product.model_name}")
            db.session.delete(product)
            deleted_products += 1

    db.session.commit()
    print(f"\nDeleted {deleted_products} products")
    print(f"Deleted {deleted_listings} junk products (and their listings).")