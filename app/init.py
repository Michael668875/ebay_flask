from flask import Flask
import os
from dotenv import load_dotenv
from app.extensions import db

load_dotenv()

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

    from .routes import bp
    app.register_blueprint(bp)    
    
    return app