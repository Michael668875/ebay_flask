from flask_ebay import get_thinkpads, save_thinkpads, app

items = get_thinkpads()
with app.app_context():
    save_thinkpads(items)