from app.extensions import db
from datetime import datetime, timezone
from slugify import slugify
from sqlalchemy import event
from sqlalchemy.orm import Session, validates
import re

def clean_text(text: str) -> str:
    # Remove emojis and other non-ASCII symbols
    return re.sub(r'[^\x00-\x7F]+', '', text).strip()

class Model(db.Model):
    __tablename__ = "models"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False, unique=True)
    slug = db.Column(db.String, nullable=False, unique=True)

    listings = db.relationship("Listing", back_populates="model", cascade="all, delete-orphan")

class Listing(db.Model):
    __tablename__ = "listings"

    id = db.Column(db.Integer, primary_key=True)
    category_id = db.Column(db.String(20), nullable=True)

    ebay_item_id = db.Column(db.String, unique=True, nullable=False, index=True)
    title = db.Column(db.String)
    price = db.Column(db.Numeric(10, 2))
    currency = db.Column(db.String(10), nullable=False)
    condition = db.Column(db.String)
    listing_type = db.Column(db.String(50))
    marketplace = db.Column(db.String)
    item_url = db.Column(db.Text)
    status = db.Column(db.String, default="ACTIVE", index=True) # ACTIVE, SOLD, ENDED
    first_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    last_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    sold_at = db.Column(db.DateTime, nullable=True)
    last_updated = db.Column(
        db.DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )


    # Parsed specs (from item details)
    cpu = db.Column(db.String)
    cpu_freq = db.Column(db.String(50), nullable=True)
    ram = db.Column(db.String)
    storage = db.Column(db.String)
    storage_type = db.Column(db.String)
    screen_size = db.Column(db.String)
    display = db.Column(db.String)
    gpu = db.Column(db.String)
    os = db.Column(db.String)

    # Link to canonical model
    model_id = db.Column(db.Integer, db.ForeignKey("models.id"), index=True)
    model = db.relationship("Model", back_populates="listings")

    price_history = db.relationship("PriceHistory", back_populates="listing")

    @validates('title')
    def sanitize_title(self, key, value):
        return clean_text(value)
    

class PriceHistory(db.Model):
    __tablename__ = "price_history"

    id = db.Column(db.Integer, primary_key=True)

    listing_id = db.Column(db.Integer, db.ForeignKey("listings.id"))
    model_id = db.Column(db.Integer, db.ForeignKey("models.id"), index=True)
    price = db.Column(db.Numeric(10, 2))
    currency = db.Column(db.String(10), nullable=False)
    recorded_at = db.Column(db.DateTime, nullable=False, default=datetime.now(timezone.utc), index=True)

    listing = db.relationship("Listing", back_populates="price_history")

@event.listens_for(Model, "before_insert")
def generate_unique_slug(mapper, connection, target):
    if not target.slug:
        # Prepend "thinkpad" for SEO in URL
        base_slug = slugify(f"thinkpad {target.name}")
        slug = base_slug
        counter = 1

        session = Session.object_session(target)
        while session.query(Model).filter_by(slug=slug).first():
            slug = f"{base_slug}-{counter}"
            counter += 1

        target.slug = slug

class TempSummaries(db.Model):
    __tablename__= "temp_summaries"

    id = db.Column(db.Integer, primary_key=True)
    category_id = db.Column(db.String(20))

    ebay_item_id = db.Column(db.String, unique=True, nullable=False)
    title = db.Column(db.String)
    price = db.Column(db.Numeric(10, 2))
    currency = db.Column(db.String(10), nullable=False)
    condition = db.Column(db.String)
    listing_type = db.Column(db.String(50))
    marketplace = db.Column(db.String)
    item_url = db.Column(db.Text)
    creation_date = db.Column(db.DateTime(timezone=True))
    first_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    last_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    sold_at = db.Column(db.DateTime(timezone=True), nullable=True)
    last_updated = db.Column(
        db.DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )

class TempDetails(db.Model):
    __tablename__= "temp_details"

    id = db.Column(db.Integer, primary_key=True)
    ebay_item_id = db.Column(db.String, unique=True, nullable=False)
    cpu = db.Column(db.String)
    cpu_freq = db.Column(db.String(50))
    ram = db.Column(db.String)
    storage = db.Column(db.String)
    storage_type = db.Column(db.String)
    screen_size = db.Column(db.String)
    display = db.Column(db.String)
    gpu = db.Column(db.String)
    os = db.Column(db.String)
    model = db.Column(db.String)
    seller_username = db.Column(db.String)
    seller_feedback_score = db.Column(db.Integer)
    seller_feedback_percent = db.Column(db.Numeric(5, 2))