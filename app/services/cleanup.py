from app import create_app, db
from app.models import Listing
from app.services.parse import load_blacklist, is_blacklisted

def remove_blacklisted_listings():
    app = create_app()

    with app.app_context():
        bl = load_blacklist()
        listings = Listing.query.all()

        to_delete = []

        for listing in listings:
            if listing.title and is_blacklisted(listing.title, bl):
                to_delete.append(listing)

        print(f"Found {len(to_delete)} blacklisted listings to delete.")

        #for listing in to_delete:
        #    print(f"Deleting: {listing.ebay_item_id} | {listing.title}")
        #    db.session.delete(listing)

        for listing in to_delete: # this is for debug. remove later
            print(f"WILL DELETE: {listing.ebay_item_id} | {listing.title}")

        #db.session.commit()
        print("Done.")

if __name__ == "__main__":
    remove_blacklisted_listings()
