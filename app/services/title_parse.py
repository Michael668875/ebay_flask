# TITLE PARSING TO REPLACE DETAILED ITEM FETCH. EXPERIMENTAL DON'T USE YET

import re
from app.models import ThinkPadModel
from app import create_app, db
from slugify import slugify

app = create_app()



title_list = ["Lenovo ThinkPad E14 Gen 7 /14/ AMD Ryzen 7- 7735U/ 16 GB RAM /512 GB SSD/ Win11"]

def normalize_title(title):
    title = title.lower()
    title = re.sub(r"\s+", " ", title)
    return title.strip()

def find_model_near_thinkpad(title, known_models):
    title = normalize_title(title)

    if "thinkpad" not in title:
        print("not thinkpad")
        return None

    after = title.split("thinkpad", 1)[1].strip()
    window = " ".join(after.split()[:4])  # next 4 tokens

    for model in sorted(known_models, key=len, reverse=True):
        if re.search(rf"\b{re.escape(model.lower())}\b", window):
            print(model)
            return model
    print("none found")
    return None



def find_model_and_insert(title, known_models):
    title = normalize_title(title)

    match = re.search(r"\be14\s+gen\s+(\d+)\b", title)

    if match:
        model_name = match.group(0).title()   # "E14 Gen 7"
        slug = slugify(model_name)            # "e14-gen-7"

        if model_name not in known_models:
            new_model = ThinkPadModel(
                name=model_name,
                slug=slug
            )
            db.session.add(new_model)
            db.session.commit()

            known_models.add(model_name)  # important if known_models is a set
            print(f"Added new model: {model_name}")
        else:
            print(f"Already exists: {model_name}")

with app.app_context():
    known_models = {m.name for m in ThinkPadModel.query.all()}
    
    for title in title_list:
        find_model_near_thinkpad(title, known_models)
        find_model_and_insert(title, known_models)






# cache model list in memory
"""from your_app.models import Model  # your SQLAlchemy model

# At app startup, e.g., in create_app() or a config module
known_models = [m.name.lower() for m in Model.query.all()]

# Sort by length descending to match longest models first
known_models.sort(key=len, reverse=True)"""



# use chached model list in stage 1 parsing
def find_model_near_thinkpad(title):
    title = title.lower()
    if "thinkpad" not in title:
        return None

    after = title.split("thinkpad", 1)[1].strip()
    window = " ".join(after.split()[:4])  # next 4 tokens

    for model in known_models:
        if f" {model} " in f" {window} ":  # simple boundary-safe check
            return model
    return None


# optional - refresh cached models periodically. Use a cron job or app reload to refresh
def refresh_known_models():
    global known_models
    known_models = [m.name.lower() for m in ThinkPadModel.query.all()]
    known_models.sort(key=len, reverse=True)


