from flask import Blueprint, render_template_string
from app.ebay_models import Listing

bp = Blueprint("main", __name__)

@bp.route("/")
def index():
    listings = Listing.query.order_by(Listing.price.asc()).all()
    return render_template_string("""
    <h1>ThinkPad Prices</h1>
    <table border="1">
        <tr><th>Title</th><th>Price</th><th>Currency</th></tr>
        {% for item in items %}
        <tr>
            <td>{{item.title}}</td>
            <td>{{item.price}}</td>
            <td>{{item.currency}}</td>
        </tr>
        {% endfor %}
    </table>
    """, items=listings)