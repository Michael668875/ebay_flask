from flask import Flask, render_template_string
from flask_sqlalchemy import SQLAlchemy
import os
from dotenv import load_dotenv

load_dotenv()

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    app.config["SQLALCHEMY_DATABASE_URI"] = (
    f"postgresql://{os.getenv('DB_USER')}:"
    f"{os.getenv('DB_PASS')}@" 
    f"{os.getenv('DB_HOST')}:5432/" 
    f"{os.getenv('DB_NAME')}"
)
    
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    db.init_app(app)

    from ebay_models import Listing

    @app.route("/")
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
    
    return app

app = create_app()

if __name__ == "__main__":
    app.run(debug=True)

