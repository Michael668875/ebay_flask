# THIS FILE DELETES ALL ENTRIES FROM THE DATABASE
# USE FOR TESTING ONLY


from app import db, create_app
from app.models import Listing, Model, PriceHistory, Specs, ModelPriceStats, TempDetails, TempSummaries

app = create_app()

with app.app_context():
    # Delete everything
    PriceHistory.query.delete()
    Specs.query.delete()
    Listing.query.delete()
    ModelPriceStats.query.delete()
    Model.query.delete()
    TempSummaries.query.delete()
    TempDetails.query.delete()
    
    db.session.commit()