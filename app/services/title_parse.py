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

def simple_format(name):
    words = name.lower().split()
    return " ".join(word[:1].upper() + word[1:] for word in words)

# use a regex pattern to find the model in the title
def find_model_by_pattern(title):
    title = normalize_title(title)

    patterns = [
    ("base_match", r"\b[a-z]+\d{1,4}[a-z]?(?:-?\d{1,2})?\b"),
    ("simple_match", r"\b(x|t|p|e|l|w|z|a|sl)(\d{1,4}[a-z]?)\b"),   
    ("number_letter_match", r"\b\d{2,3}[a-z](?=\s|$)"),
    ("edge_match", r"\bedge\s*(\d{1,2})\b"),
    ("odd_match", r"\bthinkpad\s*13(?=\s|$)"),
    ("numbers_match", r"\b\d{3}(?=\s|$)"),
    ]

    has_carbon = bool(re.search(r"\bcarbon\b", title))
    has_yoga = bool(re.search(r"\byoga\b", title))
    has_tablet = bool(re.search(r"\btablet\b", title))
    has_2in1 = bool(re.search(r"\b2[\s-]?in[\s-]?1\b", title))    
    gen_match = re.search(r"\b(\d{1,2})(?:st|nd|rd|th)\s*(?:gen|g)\b", title)
    if gen_match:
        has_gen = gen_match.group(1)
    else:
        gen_match = re.search(r"\b(?:gen|g)\s*(\d{1,2})\b", title)
        has_gen = gen_match.group(1) if gen_match else None

    
    

    """
    issues:
   
    X9-14 G1     
        
    base_match X13 2-in-1 Gen 13
    'Lenovo ThinkPad X13 2-in-1 Gen 5 Core Ultra 13th Gen 135U 262GB 16GB 1920 x 1200',

    may also try to insert "None" as a model

    """
    # results must be normalise to match db values. ie lower() then title() Gen 2 replaces G2, put spaces where needed etc.

    # return first match only
    for name, pattern in patterns:
        match = re.search(pattern, title)
        if match:
            parts = [simple_format(match.group(0))]

            if has_carbon:
                parts.append("Carbon")
            if has_yoga:
                parts.append("Yoga")
            if has_tablet:
                parts.append("Tablet")
            if has_2in1:
                parts.append("2-in-1")
            if has_gen:
                parts.append(f"Gen {has_gen}")

            model_name = " ".join(parts)

            print(name, model_name)
            return model_name
        
    print("no match")
    return None
        
#    # return all matches
#    matches = []
#
#    for name, pattern in patterns:
#        match - re.searh(pattern, title)
#        if match:
#            matches.append((name, match.group(0)))
#    print(matches)
#    return matches
        

# insert newly discovered model names into temp table    
def insert_temp_model(model_name, known_models): 

    if model_name not in known_models:
        try:
            existing = TempModel.query.filter_by(temp_name=model_name).first()

            if not existing:
                new_model = TempModel(
                    temp_name=model_name,
                    seen_count=1
                )
                db.session.add(new_model)
                db.session.commit()

                print(f"Added new model: {model_name}")
            else:
                existing.seen_count += 1
                db.session.commit()
                print(f"Already exists in TempModel: {model_name}")

        except Exception as e:
            print(f"Error inserting {model_name}: {e}")

    else:
        print(f"Already exists: {model_name}")



with app.app_context():
    known_models = {m.name for m in ThinkPadModel.query.all()}

    for title in title_list:
        #find_model_near_thinkpad(title, known_models)
        #candidates = find_model_by_pattern(title)
        #insert_temp_model(candidates, known_models)
        find_model_by_pattern(title)
        

# Parse title for CPU

# Parse title for RAM values

# Parse title for STORAGE values

# Parse title for STORAGE TYPE