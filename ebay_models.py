from flask_ebay import db
from datetime import datetime, timezone


class Listing(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ebay_item_id = db.Column(db.String(50), unique=True, nullable=False)
    title = db.Column(db.Text, nullable=False)
    price = db.Column(db.Float, nullable=False)
    currency = db.Column(db.String(10), nullable=False)
    last_updated = db.Column(
        db.DateTime(timezone=True), 
        default=datetime.now(timezone.utc), 
        onupdate=datetime.now(timezone.utc)
    )

class PriceHistory(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ebay_item_id = db.Column(db.String(50), nullable=False)
    price = db.Column(db.Float, nullable=False)
    timestamp = db.Column(
        db.DateTime(timezone=True), 
        default=lambda: datetime.now(timezone.utc)
    )
