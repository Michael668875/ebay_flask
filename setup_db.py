from app.init import create_app
from app.extensions import db
from app.ebay_models import Product, Listing, PriceHistory

app = create_app()

with app.app_context():
    db.create_all()  # <-- This creates all tables in your database