from app import create_app
from app.extensions import db

app = create_app()

with app.app_context():
    db.create_all()  # <-- This creates all tables in your database
    


# Use these commands after changing the database instead of running this file

# flask db init
# flask db migrate -m "Initial schema"
# flask db upgrade

# If Flask complains about not finding the app, set:
# set FLASK_APP=run.py