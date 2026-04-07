# TITLE PARSING TO REPLACE DETAILED ITEM FETCH. EXPERIMENTAL DON'T USE YET

import re
from app.models import ThinkPadModel, TempModel
from app import create_app, db
from slugify import slugify
from app.services.titles import titles

app = create_app()



#title_list = ["Lenovo ThinkPad E14 Gen 7 /14/ AMD Ryzen 7- 7735U/ 16 GB RAM /512 GB SSD/ Win11",
#              "Lenovo ThinkPad E14 Gen 8 /14/ AMD Ryzen 7- 7735U/ 16 GB RAM /512 GB SSD/ Win11",
#              "Lenovo ThinkPad E14 Gen 6 /14/ AMD Ryzen 7- 7735U/ 16 GB RAM /512 GB SSD/ Win11",              
#              ]
#

title_list = titles

def normalize_title(title):
    title = title.lower()
    title = re.sub(r"\s+", " ", title)
    return title.strip()

# find the model in the first four words after "thinkpad"
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


# use a regex pattern to find the model in the title and save it to db
def find_model_and_insert(title, known_models):
    title = normalize_title(title)

    match = re.search(r"\be14\s+gen\s+(\d+)\b", title)

    if match:
        model_name = match.group(0).title()   # "E14 Gen 7"

        # return model_name

        if model_name not in known_models:
            try:
                existing = TempModel.query.filter_by(temp_name=model_name).first()

                if not existing:
                    new_model = TempModel(
                        temp_name=model_name
                    )
                    db.session.add(new_model)
                    db.session.commit()

                    known_models.add(model_name)
                    print(f"Added new model: {model_name}")
                else:
                    print(f"Already exists in TempModel: {model_name}")

            except Exception as e:
                print(f"Error inserting {model_name}: {e}")

        else:
            print(f"Already exists: {model_name}")



with app.app_context():
    known_models = {m.name for m in ThinkPadModel.query.all()}

    for title in title_list:
        find_model_near_thinkpad(title, known_models)
        #find_model_and_insert(title, known_models)
        

# Parse title for CPU

# Parse title for RAM values

# Parse title for STORAGE values

# Parse title for STORAGE TYPE