from flask import Flask, render_template_string
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv
load_dotenv()


app = Flask(__name__)

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
    params = {"q": "thinkpad", "limit": "5"}
    resp = requests.get(url, headers=headers, params=params)
    return resp.json().get("itemSummaries", [])

@app.route("/")
def index():
    items = get_thinkpads()
    html = """
    <h1>ThinkPad Prices</h1>
    <table border="1">
        <tr><th>Title</th><th>Price</th><th>Currency</th></tr>
        {% for item in items %}
        <tr>
            <td>{{item.title}}</td>
            <td>{{item.price.value}}</td>
            <td>{{item.price.currency}}</td>
        </tr>
        {% endfor %}
    </table>
    """
    return render_template_string(html, items=items)

if __name__ == "__main__":
    app.run(debug=True)
