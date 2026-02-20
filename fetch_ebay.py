from flask_ebay import app, db
from ebay_models import Listing, PriceHistory
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv

load_dotenv()

# Production credentials

CLIENT_ID = os.environ.get("EBAY_CLIENT_ID")
CLIENT_SECRET = os.environ.get("EBAY_CLIENT_SECRET")

def get_token():
    auth = b64encode(f"{CLIENT_ID}:{CLIENT_SECRET}".encode()).decode()
    token_url = "https://api.ebay.com/identity/v1/oauth2/token"
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": f"Basic {auth}"
    }
    data = {
        "grant_type": "client_credentials",
        "scope": "https://api.ebay.com/oauth/api_scope"
    }
    resp = requests.post(token_url, headers=headers, data=data)
    return resp.json()["access_token"]

def get_thinkpads():
    token = get_token()
    url = "https://api.ebay.com/buy/browse/v1/item_summary/search"
    headers = {
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": "EBAY_US"
    }
    params = {"q": "thinkpad", "limit": "100"}
    resp = requests.get(url, headers=headers, params=params)
    return resp.json().get("itemSummaries", [])
    

# This handles duplicates automatically and keeps a full price history.
def save_thinkpads(items):
    for item in items:
        ebay_id = item["itemId"]
        title = item["title"]
        price = float(item["price"]["value"])
        currency = item["price"]["currency"]

        # Check if listing exists
        listing = Listing.query.filter_by(ebay_item_id=ebay_id).first()

        if listing:
            # Update only if price changed
            if listing.price != price:
                listing.price = price
                listing.title = title  # optional, in case title changed
                db.session.add(listing)

                # Add price history
                history = PriceHistory(
                    ebay_item_id=ebay_id,
                    price=price
                )
                db.session.add(history)
        else:
            # New listing
            new_listing = Listing(
                ebay_item_id=ebay_id,
                title=title,
                price=price,
                currency=currency
            )
            db.session.add(new_listing)

            # Add initial price history
            history = PriceHistory(
                ebay_item_id=ebay_id,
                price=price
            )
            db.session.add(history)

    db.session.commit()

if __name__ == "__main__":
    items = get_thinkpads()
    save_thinkpads(items)

