# RUN THIS MANUALLY TO CREATE ALL TABLES IN DB
# ONLY USE AFTER DROPPING DB OTHERWISE USE flask db migrate -m "some message", and flask db upgrade

from app import create_app
from app.extensions import db

app = create_app()

with app.app_context():
    db.create_all()  # <-- This creates all tables in your database