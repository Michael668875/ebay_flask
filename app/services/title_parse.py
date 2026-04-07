# TITLE PARSING TO REPLACE DETAILED ITEM FETCH. EXPERIMENTAL DON'T USE YET

import re
from app.models import ThinkPadModel, TempModel
from app import create_app, db
from slugify import slugify
from app.services.titles import titles

app = create_app()

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


# use a regex pattern to find the model in the title
def find_model_by_pattern(title):
    title = normalize_title(title)

    gen_match = re.search(r"\b[a-z]+(\d+)[a-z]?\s+(gen|g)\s*(\d+)\b", title)

    yoga_match = re.search(r"\b([a-z]+(\d+)\s+yoga)(\s*(gen|g)\s*(\d+))?\b", title)

    carbon_match = re.search(r"\b([a-z]+(\d+)\s+carbon)(\s*(gen|g)\s*(\d+))?\b", title)

    simple_match = re.search(r"\b(x1|x9|x13|x12|t|p|e|l|w|z|a|sl|11e)\s*-?\s*(\d{1,4}(?:\s*2-in-1)?[a-z]?)\b", title) # this needs fixing. 

    X1_match = re.search(r"\b(x1)(?:\s*2-in-1)?(\s*(gen|g)\s*(\d+))?\b", title)

    legacy_match = re.search(r"\b([a-z]+\d{2,4}[a-z]?)\b", title)

    """
    issues:
    X1 Carbon 1st Gen
    X13 2-in-1 Gen 5
    EDGE 16 Mobile Workstation
    X1 Tablet Gen 3
    X12 Detachable Core 
    X1 2-in-1 Gen 10 
    X1 Yoga 3rd Gen
    X9-14 G1 Core Ultra 5
    T16 P16s
    X13 Gen 2a
    L13 Core
    X1

    E15  found this instead: Tp0117A

    x1 2-in-1 gen 10 found w11

    """

    if gen_match :
        model_name = gen_match.group(0).title()   # "E14 Gen 7"
        print(model_name)
        return model_name
    
    elif yoga_match:
        model_name = yoga_match.group(0).title()
        print(model_name)
        return model_name
    
    elif carbon_match:
        model_name = carbon_match.group(0).title()
        print(model_name)
        return model_name
    
    elif simple_match:
        model_name = simple_match.group(0).title()
        print(model_name)
        return model_name
    
    elif X1_match:
        model_name = X1_match.group(0).title()
        print(model_name)
        return model_name
    
    elif legacy_match:
        model_name = legacy_match.group(0).title()
        print(model_name)
        return model_name
    
    else:
        print("no match")
        return None

# insert newly discovered model names into temp table    
def insert_temp_model(model_name, known_models): 

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
        #find_model_near_thinkpad(title, known_models)
        find_model_by_pattern(title)
        

# Parse title for CPU

# Parse title for RAM values

# Parse title for STORAGE values

# Parse title for STORAGE TYPE