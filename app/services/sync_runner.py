from app import create_app
from app.services.sync import save_thinkpads
from app.services.fetch import get_thinkpads

app = create_app()

if __name__ == "__main__":
    with app.app_context():
        items = get_thinkpads()
        save_thinkpads(items, app)
        print(f"Synced {len(items)} ThinkPad listings.")