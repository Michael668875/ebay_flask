from app.extensions import db
from datetime import datetime, timezone


class Product(db.Model):
    __tablename__ = 'products'

    id = db.Column(db.Integer, primary_key=True)
    model_name = db.Column(db.String(100), nullable=False)
    cpu = db.Column(db.String(100), nullable=True)
    cpu_freq = db.Column(db.String(10), nullable=True)
    ram = db.Column(db.String(50), nullable=True)
    storage = db.Column(db.String(50), nullable=True)
    storage_type = db.Column(db.String(20), nullable=True)

    # Relationship: Product -> Listings
    listings = db.relationship(
        'Listing',
        backref='product',
        cascade="all, delete-orphan",
        lazy=True
    )


class Listing(db.Model):
    __tablename__ = 'listings'

    id = db.Column(db.Integer, primary_key=True)
    category_id = db.Column(db.String(20), nullable=True)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    ebay_item_id = db.Column(db.String(50), nullable=False, unique=True)
    marketplace = db.Column(db.String(10), nullable=False)
    title = db.Column(db.Text, nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)  # money values
    currency = db.Column(db.String(10), nullable=False)
    condition = db.Column(db.String(50))
    listing_type = db.Column(db.String(50))
    status = db.Column(db.String, default="ACTIVE") # ACTIVE, SOLD, ENDED
    first_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    last_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    sold_at = db.Column(db.DateTime, nullable=True)
    url = db.Column(db.Text)
    last_updated = db.Column(
        db.DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )

    # Relationship: Listing -> PriceHistory
    price_history = db.relationship(
        'PriceHistory',
        backref='listing',
        cascade="all, delete-orphan",
        lazy=True
    )


class PriceHistory(db.Model):
    __tablename__ = 'price_history'

    id = db.Column(db.Integer, primary_key=True)
    listing_id = db.Column(db.Integer, db.ForeignKey('listings.id'), nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    currency = db.Column(db.String(10), nullable=False)
    checked_at = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))


class Marketplace(db.Model):
    __tablename__ = "marketplaces"

    id = db.Column(db.Integer, primary_key=True)
    country_code = db.Column(db.String(10), nullable=False)   # "US"
    marketplace_id = db.Column(db.String(20), nullable=False, unique=True)  # "EBAY_US"
    enabled = db.Column(db.Boolean, default=True)

    def __repr__(self):
        return f"<Marketplace {self.marketplace_id}>"
    
class ThinkPadModel(db.Model):
    __tablename__ = "models"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=True, nullable=False)

class CPU(db.Model):
    __tablename__ = "cpu"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(30), unique=True, nullable=False)

class RAM(db.Model):
    __tablename__ = "ram"
    id = db.Column(db.Integer, primary_key=True)
    size = db.Column(db.String(20), unique=True, nullable=False)

class Storage(db.Model):
    __tablename__ = "storage"
    id = db.Column(db.Integer, primary_key=True)
    size = db.Column(db.String(20), unique=True, nullable=False)