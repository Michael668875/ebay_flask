# THIS FILE DELETES ALL ENTRIES FROM THE DATABASE
# USE FOR TESTING ONLY


from app import db, create_app
from app.models import Listing, Model, PriceHistory

app = create_app()

with app.app_context():
    # Delete everything
    PriceHistory.query.delete()
    Listing.query.delete()
    Model.query.delete()
    
    db.session.commit()