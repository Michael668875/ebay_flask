from app import create_app
from app.services.testing_db import *

app = create_app()

with app.app_context():
    insert_summaries_from_log()
    insert_details_from_log()