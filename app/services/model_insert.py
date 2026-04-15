from app import db
from app.models import ThinkPadModel
import re
from app import create_app
app = create_app()

def make_slug(name):
    slug = re.sub(r'[^a-z0-9]+', '-', name.lower()).strip('-')
    return f"thinkpad-{slug}"


def load_models(filepath="app/services/model_list.txt"):
    with open(filepath, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f if line.strip()]

    inserted = 0

    for name in lines:
        slug = make_slug(name)

        exists = ThinkPadModel.query.filter_by(name=name).first()
        if exists:
            continue

        model = ThinkPadModel(name=name, slug=slug)
        db.session.add(model)
        inserted += 1

    db.session.commit()
    print(f"Inserted {inserted} models")

if __name__ == "__main__":
    with app.app_context():   
        load_models()