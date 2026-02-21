from app import create_app
from app.ebay_sync import save_thinkpads
from fetch_ebay import get_thinkpads

app = create_app()

if __name__ == "__main__":
    with app.app_context():
        items = get_thinkpads()
        save_thinkpads(items, app)
        print(f"Synced {len(items)} ThinkPad listings.")