from app import create_app
from app.extensions import db
from app.models import Listing

app = create_app()

with app.app_context():
    print("Database URL:", app.config["SQLALCHEMY_DATABASE_URI"])
    print("Listing count:", Listing.query.count())