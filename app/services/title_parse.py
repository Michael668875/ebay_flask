# TITLE PARSING TO REPLACE DETAILED ITEM FETCH. EXPERIMENTAL DON'T USE YET

import re
from app.models import ThinkPadModel, TempModel, CPU
from app import create_app, db
from slugify import slugify
from app.services.titles import titles

app = create_app()

title_list = titles

#title_list = ['Lenovo ThinkPad E16 G2 16 inch FHD+ Ryzen 7 7735HS 32GB DDR5  SSD WiFi 6E Win',
#'Lenovo ThinkPad T14s Gen 1 Ryzen 7 PRO 4750U 16GB 512GB SSD Touch 14" Win11 Pro', '45gb 67tb', '71mb 389gb']

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

    # discard titles that don't contain "thinkpad"
    if not re.search(r"\bthinkpad\b", title):
        print("not thinkpad")
        return None

    patterns = [
    #("base_match", r"\b[a-z]+\d{1,4}[a-z]?(?:-?\d{1,2})?\b"),
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
    #new_model = re.search(r"\b(t14|t14s|t16|t16g|x13|x12|x1|x9|e14|e15|e16|l13|l14|l16|p1|p14s|p15v|p16|p16s|p16v|p17|thinkpad 13|11e)\b", title)  
    #gen_match = re.search(r"\b(?:(\d{1,2})(?:st|nd|rd|th)\s*)?(?:gen|g)(?:\s*(\d{1,2}))?\b", title)
    #has_gen = gen_match.group(1) or gen_match.group(2) if gen_match and new_model else None   
        
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
            #if has_gen:
            #    parts.append(f"Gen {has_gen}")

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

    if model_name not in known_models and model_name != None:
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
                #print(f"Already exists in TempModel: {model_name}")

        except Exception as e:
            print(f"Error inserting {model_name}: {e}")

   # else:
   #     print(f"Already exists: {model_name}")



# Parse title for CPU

    # compare to canon list in db first

def find_cpu_canon(title):
    title = normalize_title(title)

    known_cpus = [c.name for c in CPU.query.all()]

    for cpu in sorted(known_cpus, key=len, reverse=True):
        if re.search(rf"\b{re.escape(cpu.lower())}\b", title):
            return cpu
    return None

    

def find_cpu_pattern(title):
    title = normalize_title(title)

    # Intel
    intel = re.search(r"\bi[3579]\s?\d{4,5}[a-z]{0,2}\b", title)
    if intel:
        return intel.group(0).upper()

    # AMD
    amd = re.search(r"\bryzen\s?[3579]\s?\d{4}[a-z]{0,2}\b", title)
    if amd:
        return amd.group(0).upper()

    # Fallback
    fallback = re.search(r"\b(i3|i5|i7|i9|ryzen 3|ryzen 5|ryzen 7|ryzen 9)\b", title)
    if fallback:
        return fallback.group(0).upper()

    return None

# Parse title for RAM and Storage values

def find_memory(title):
    title = normalize_title(title)
    matches = re.findall(r"\b(\d+)\s?(mb|gb|tb)\b", title)

    if not matches:
        return None, None
    
    values = []
    for num, unit in matches:
        num = int(num)
        unit = unit.lower()
        if unit == "tb":
            num *= 1024
        elif unit == "mb":
            num /= 1024

        values.append(num)

    values.sort()

    if len(values) == 1:
        # if only one value, call it ram if less than 64 otherwise call it storage
        val = values[0]
        if val <= 64:
            return val, None
        else:
            return None, val
    
    ram = values[0]
    storage = values[-1]

    return ram, storage

# POSSIBLY, ADD A FILTER TO FIND VALUE NEAR SSD, HDD, NVME ETC TO GET STORAGE VALUE MORE ACCURATELY


# Parse title for STORAGE TYPE

def find_storage_type(title):
    title = normalize_title(title)
    match = re.search(r"\b(hdd|ssd|nvme)\b", title)

    if not match:
        return None

    type = match.group(0)
    
    if type == "hdd":
        type = "HDD"
    elif type == "ssd":
        type = "SSD"
    elif type == "nvme":
        type = "NVMe"

    return type



with app.app_context():
    known_models = {m.name for m in ThinkPadModel.query.all()}

    for title in title_list:
        find_model_near_thinkpad(title, known_models)
        #candidates = find_model_by_pattern(title)
        #insert_temp_model(candidates, known_models)
        #find_model_by_pattern(title)
        #find_memory(title)
        #print(find_memory(title))
        #print(find_storage_type(title))
        #print(find_cpu_canon(title))
        #print(find_cpu_pattern(title))
