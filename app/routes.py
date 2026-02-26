from flask import Blueprint, render_template_string
from app.models import Listing

bp = Blueprint("main", __name__)



@bp.route("/")
def index():
    # Query listings with their related product info
    listings = Listing.query.join(Listing.product).order_by(Listing.price.asc()).all()

    return render_template_string("""
    <h1>ThinkPad Prices</h1>
    <table border="1">
        <tr>
            <th>Model</th>
            <th>Price</th>
            <th>Currency</th>
            <th>CPU</th>
            <th>RAM</th>
            <th>Storage</th>
            <th>Title</th>
            <th>Condition</th>
            <th>Listing Type</th>
            <th>Last Updated</th>
        </tr>
        {% for item in items %}
        <tr>
            <td>{{item.product.model_name}}</td>
            <td>${{item.price}}</td>
            <td>{{item.currency}}</td>
            <td>{{item.product.cpu}}</td>
            <td>{{item.product.ram}}</td>
            <td>{{item.product.storage}}</td>
            <td><a href = "{{item.url}}" target =" _blank">{{item.title}}</a></td>
            <td>{{item.condition}}</td>
            <td>{{item.listing_type}}</td>
            <td>{{item.last_updated}}</td>
        </tr>
        {% endfor %}
    </table>
    """, items=listings)

