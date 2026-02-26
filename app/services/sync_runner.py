from app import create_app
from app.services.sync import save_thinkpads
from app.services.fetch import get_thinkpads
from app.services.retry_failed_items import retry_failed

def run_sync():
    app = create_app()
    
    with app.app_context():

        items = get_thinkpads()
        save_thinkpads(items, app)
        retry_failed(app)

        print(f"Synced {len(items)} ThinkPad listings.")
        
if __name__ == "__main__":
    run_sync()