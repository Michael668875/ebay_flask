from app.extensions import db
from datetime import datetime, timezone
from slugify import slugify
from sqlalchemy import event
from sqlalchemy.orm import Session, validates
from sqlalchemy.sql import func
import re


class Model(db.Model):
    __tablename__ = "models"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False, unique=True, index=True)
    slug = db.Column(db.String, nullable=False, unique=True)

    listings = db.relationship("Listing", back_populates="model", cascade="all, delete-orphan")

class Specs(db.Model):
    __tablename__ = "specs"

    id = db.Column(db.Integer, primary_key=True)
    listing_id = db.Column(db.Integer, db.ForeignKey("listings.id"), unique=True, index=True)

    # Parsed specs (from item details)
    cpu = db.Column(db.String)
    cpu_freq = db.Column(db.String(50), nullable=True)
    ram = db.Column(db.Integer)
    storage = db.Column(db.Integer)
    storage_type = db.Column(db.String)
    screen_size = db.Column(db.String)
    display = db.Column(db.String)
    gpu = db.Column(db.String)
    os = db.Column(db.String)

    listing = db.relationship("Listing", back_populates="specs")

    __table_args__ = (
        db.Index("idx_specs_search", "cpu", "ram", "storage"),
    )

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
    status = db.Column(db.String, default="ACTIVE", server_default="ACTIVE", index=True) # ACTIVE, SOLD, ENDED
    first_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    last_seen = db.Column(db.DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))
    sold_at = db.Column(db.DateTime, nullable=True)
    last_updated = db.Column(
        db.DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )

    # Link to canonical model
    model_id = db.Column(db.Integer, db.ForeignKey("models.id"), index=True)
    model = db.relationship("Model", back_populates="listings")

    price_history = db.relationship("PriceHistory", back_populates="listing")
    specs = db.relationship("Specs", back_populates="listing", uselist=False)

        

class PriceHistory(db.Model):
    __tablename__ = "price_history"

    id = db.Column(db.Integer, primary_key=True)

    listing_id = db.Column(db.Integer, db.ForeignKey("listings.id"))
    model_id = db.Column(db.Integer, db.ForeignKey("models.id"), index=True)
    price = db.Column(db.Numeric(10, 2))
    currency = db.Column(db.String(10), nullable=False)
    recorded_at = db.Column(db.DateTime(timezone=True), nullable=False, server_default=func.now(), index=True)

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


class Marketplace(db.Model):
    __tablename__ = "marketplaces"

    id = db.Column(db.Integer, primary_key=True)
    country_code = db.Column(db.String(10), nullable=False)   # "US"
    marketplace_id = db.Column(db.String(20), nullable=False, unique=True)  # "EBAY_US"
    enabled = db.Column(db.Boolean, default=True)

    def __repr__(self):
        return f"<Marketplace {self.marketplace_id}>"
    
class ThinkPadModel(db.Model):
    __tablename__ = "model_list"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), unique=True, nullable=False)

class CPU(db.Model):
    __tablename__ = "cpu"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), unique=True, nullable=False)

class RAM(db.Model):
    __tablename__ = "ram"
    id = db.Column(db.Integer, primary_key=True)
    size = db.Column(db.String(20), unique=True, nullable=False)

class Storage(db.Model):
    __tablename__ = "storage"
    id = db.Column(db.Integer, primary_key=True)
    size = db.Column(db.String(20), unique=True, nullable=False)

class ModelPriceStats(db.Model):
    __tablename__ = "model_price_stats"

    id = db.Column(db.Integer, primary_key=True)

    model_id = db.Column(db.Integer, db.ForeignKey("models.id"), unique=True, index=True)
    marketplace = db.Column(db.String)
    avg_price = db.Column(db.Numeric(10,2))
    min_price = db.Column(db.Numeric(10,2))
    max_price = db.Column(db.Numeric(10,2))
    listing_count = db.Column(db.Integer)

    updated_at = db.Column(db.DateTime(timezone=True))