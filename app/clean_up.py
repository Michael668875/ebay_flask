from app import create_app
from app.extensions import db
from app.models import Product
from app.services.model_parser import is_real_laptop

app = create_app()

with app.app_context():
    # Fetch all products
    products = Product.query.all()

    deleted_count = 0

    for product in products:
        item_specifics = {
            "model": product.model_name,
            "processor": product.cpu,
            "ram": product.ram,
            "storage": product.storage,
        }

        if not is_real_laptop(item_specifics):
            print(f"Junk detected: model name: {product.model_name} cpu: {product.cpu} ram: {product.ram} storage: {product.storage}") # uncomment db.session.delete(product) when you’re confident.
           # db.session.delete(product)
            deleted_count += 1

    db.session.commit()
    print(f"Deleted {deleted_count} junk products (and their listings).")