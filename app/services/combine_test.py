from app import create_app
from app.services.testing_db import *
from app.services.pipeline import run_pipeline


app = create_app()

with app.app_context():
    #insert_summaries_from_log()
    #insert_details_from_log()
    insert_into_temp_summaries()    
    insert_into_temp_details()
    run_pipeline()