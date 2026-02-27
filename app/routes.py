from flask import Blueprint, render_template_string, render_template, abort
from app.models import Listing, Marketplace

bp = Blueprint("main", __name__)

def get_markets():
    from app.models import Marketplace
    return Marketplace.query.filter_by(enabled=True).all()

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
            <td>{{item.product.cpu}} {{item.product.cpu_freq}}</td>
            <td>{{item.product.ram}}</td>
            <td>{{item.product.storage}} {{item.product.storage_type}}</td>
            <td><a href = "{{item.url}}" target =" _blank">{{item.title}}</a></td>
            <td>{{item.condition}}</td>
            <td>{{item.listing_type}}</td>
            <td>{{item.last_updated}}</td>
        </tr>
        {% endfor %}
    </table>
    """, items=listings)

@bp.route("/<country>/<model_slug>/")
def model_page(country, model_slug):
    country = country.lower()

    market = get_markets()

    if country not in market:
        abort(404)

    marketplace = market[country]

    listings = (
        Listing.query
        .filter_by(model_slug=model_slug,
                   marketplace=marketplace,
                   status="ACTIVE")
        .all()
    )

    if not listings:
        abort(404)

    return render_template(
        "model.html",
        listings=listings,
        country=country,
        model_slug=model_slug
    )