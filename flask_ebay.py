from flask import Flask, render_template_string
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv
from flask_sqlalchemy import SQLAlchemy


load_dotenv()


app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get("DATABASE_URL")


app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

class Listing(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ebay_item_id = db.Column(db.String(50), unique=True)
    title = db.Column(db.Text)
    price = db.Column(db.Float)
    currency = db.Column(db.String(10))

# used to create the tables. Remove later
# with app.app_context():
#     db.create_all()

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
    params = {"q": "thinkpad", "limit": "10"}
    resp = requests.get(url, headers=headers, params=params)
    return resp.json().get("itemSummaries", [])

def save_listings(items):
    for item in items:
        # Skip if this eBay item already exists in DB
        if Listing.query.filter_by(ebay_item_id=item["itemId"]).first():
            continue

        listing = Listing(
            ebay_item_id=item["itemId"],
            title=item.get("title"),
            price=float(item["price"]["value"]),
            currency=item["price"]["currency"]
        )
        db.session.add(listing)
    db.session.commit()


@app.route("/")
def index():
    items = get_thinkpads()
    
    # Save to DB
    save_listings(items)

    # display items from db
    listings = Listing.query.limit(10).all()

    html = """
    <h1>ThinkPad Prices</h1>
    <table border="1">
        <tr><th>Title</th><th>Price</th><th>Currency</th></tr>
        {% for item in listings %}
        <tr>
            <td>{{item.title}}</td>
            <td>{{item.price}}</td>
            <td>{{item.currency}}</td>
        </tr>
        {% endfor %}
    </table>
    """
    return render_template_string(html, listings=listings)

if __name__ == "__main__":
    app.run(debug=True)
