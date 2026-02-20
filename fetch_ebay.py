from app import create_app
from app.extensions import db
from app.ebay_models import Product, Listing, PriceHistory
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv
from datetime import datetime, timezone

load_dotenv()

app = create_app()

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

def parse_product_details(title: str):
    """
    Fallback parser if itemSpecifics are missing.
    Tries to extract model, CPU, RAM, storage from title.
    """
    model = " ".join(title.split()[0:3])  # crude first 3 words as model
    cpu = ram = storage = "Unknown"

    title_lower = title.lower()
    if "i7" in title_lower:
        cpu = "i7"
    elif "i5" in title_lower:
        cpu = "i5"

    if "16gb" in title_lower:
        ram = "16GB"
    elif "8gb" in title_lower:
        ram = "8GB"

    if "512gb" in title_lower:
        storage = "512GB SSD"
    elif "256gb" in title_lower:
        storage = "256GB SSD"

    return model, cpu, ram, storage
    

# This handles duplicates automatically and keeps a full price history.
def save_thinkpads(items):
    """
    Save ThinkPad items into Product, Listing, and PriceHistory.
    Uses eBay itemSpecifics first, falls back to title parsing.
    """
    with app.app_context():
        for item in items:
            ebay_id = item["itemId"]
            title = item["title"]
            price = float(item["price"]["value"])
            currency = item["price"]["currency"]

            # --- Try eBay item specifics ---
            cpu = ram = storage = None
            specifics = item.get("itemSpecifics", {})
            for nv in specifics.get("nameValues", []):
                name = nv.get("name", "").lower()
                value_list = nv.get("value", [])
                if not value_list:
                    continue
                value = value_list[0]

                if "processor" in name:
                    cpu = value
                elif "ram" in name:
                    ram = value
                elif "storage" in name:
                    storage = value

            # --- Fallback to title parsing if any missing ---
            if not cpu or not ram or not storage:
                model_name_fallback, cpu_fallback, ram_fallback, storage_fallback = parse_product_details(title)
                cpu = cpu or cpu_fallback
                ram = ram or ram_fallback
                storage = storage or storage_fallback
                model_name = model_name_fallback
            else:
                # If item specifics exist, use first 3 words as model_name
                model_name = " ".join(title.split()[0:3])

            # --- Check or create Product ---
            product = Product.query.filter_by(model_name=model_name).first()
            if not product:
                product = Product(model_name=model_name, cpu=cpu, ram=ram, storage=storage)
                db.session.add(product)
                db.session.flush()  # get product.id

            # --- Check or create Listing ---
            listing = Listing.query.filter_by(ebay_item_id=ebay_id).first()

            listing_type = ",".join(item.get("buyingOptions", []))  # Usually ["FIXED_PRICE"]

            if listing:
                # Update listing if price changed
                if listing.price != price:
                    listing.price = price
                    listing.title = title
                    listing.currency = currency
                    listing.condition = item.get("condition")
                    listing.listing_type = listing_type
                    listing.last_updated = datetime.now(timezone.utc)
                    db.session.add(listing)

                    # Add price history
                    history = PriceHistory(
                        listing_id=listing.id,
                        price=price,
                        currency=currency
                    )
                    db.session.add(history)
            else:
                # New listing
                new_listing = Listing(
                    product_id=product.id,
                    ebay_item_id=ebay_id,
                    title=title,
                    price=price,
                    currency=currency,
                    condition=item.get("condition"),
                    listing_type=listing_type
                )
                db.session.add(new_listing)
                db.session.flush()  # get new_listing.id

                # Add initial price history
                history = PriceHistory(
                    listing_id=new_listing.id,
                    price=price,
                    currency=currency
                )
                db.session.add(history)

        db.session.commit()

if __name__ == "__main__":
    items = get_thinkpads()
    save_thinkpads(items)

