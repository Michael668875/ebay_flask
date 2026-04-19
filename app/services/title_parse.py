# TITLE PARSING TO REPLACE DETAILED ITEM FETCH. EXPERIMENTAL DON'T USE YET

import re
from app.models import ThinkPadModel, CPU, Model, Listing, Specs
from app import create_app, db
from app.services.titles import titles

app = create_app()

#title_list = titles # change this to title in temp_summaries or listings

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
        #print("not thinkpad")
        return None, None

    after = title.split("thinkpad", 1)[1].strip()
    window = " ".join(after.split()[:4])  # next 4 tokens

    for model in sorted(known_models, key=len, reverse=True):
        if re.search(rf"\b{re.escape(model.lower())}\b", window):
            canon_id = known_models[model]
            #print(model)
            return model, canon_id

    # use pattern match if no canon model in title
    # fallback regex
    result = find_model_by_pattern(title)

    if result:
        return result, None

    return None, None

def simple_format(name):
    words = name.lower().split()
    return " ".join(word[:1].upper() + word[1:] for word in words)

# use a regex pattern to find the model in the title
def find_model_by_pattern(title):
    title = normalize_title(title)

    # discard titles that don't contain "thinkpad"
    if not re.search(r"\bthinkpad\b", title):
        #print("not thinkpad")
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

            #print(name, model_name)
            return model_name
        
    #print("no match")
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


def insert_model_from_title(session, listing, known_models):
    model_name, canon_id = find_model_near_thinkpad(listing.title, known_models)

    if not model_name:
        return

    if listing.model:
        # update existing row
        listing.model.name = model_name.strip()
        listing.model.canon_model_id = canon_id
    else:
        # create new row
        model = Model(
            name=model_name.strip(),
            canon_model_id=canon_id,
            listing=listing,
        )
        session.add(model)


def process_models():
    known_models = {m.name: m.id for m in ThinkPadModel.query.all()}
    cpu_lookup = build_cpu_lookup()   
    cpu_list = CPU.query.all()        

    for listing in Listing.query.yield_per(500):
        insert_model_from_title(db.session, listing, known_models)

        ram, storage = find_memory(listing.title)
        storage_type = find_storage_type(listing.title)
        cpu = cpu_match(listing.title, cpu_lookup, cpu_list)

        upsert_specs(listing, ram, storage, storage_type, cpu)

  


def upsert_specs(listing, ram, storage, storage_type, cpu):
    if not listing.specs:
        listing.specs = Specs()

    if ram is not None:
        listing.specs.ram = ram

    if storage is not None:
        listing.specs.storage = storage

    if storage_type:
        listing.specs.storage_type = storage_type

    if cpu:
        listing.specs.cpu = cpu


# Parse title for CPU

def build_cpu_lookup():
    cpus = CPU.query.filter(CPU.cpu_num.isnot(None)).all()
    return {cpu.cpu_num.upper(): cpu for cpu in cpus}


def build_cpu_name_list():
    cpus = CPU.query.all()
    return cpus

# compare to canon list in db first
def find_cpu_canon(title, cpu_list):
    title = normalize_title(title)

    for cpu in sorted(cpu_list, key=lambda x: len(x.name or ""), reverse=True):
        if cpu.name and normalize_title(cpu.name) in title:
            return cpu.name

    return None    

def find_cpu_pattern(title):
    title = normalize_title(title)

    # Intel full match (i7 1185G7 etc)
    intel = re.search(r"\bi[3579][\s\-]?\d{4,5}[a-z]{1,3}\b", title, re.IGNORECASE)
    if intel:
        return format_cpu_match(intel.group(0))

    # AMD full match (ryzen 5 5600U etc)
    amd = re.search(r"\bryzen[\s\-]?[3579][\s\-]?(pro)?[\s\-]?\d{4}[a-z]{1,3}\b", title, re.IGNORECASE)
    if amd:
        return format_cpu_match(amd.group(0))

    # Fallback (family only)
    fallback = re.search(r"\b(i3|i5|i7|i9|ryzen 3|ryzen 5|ryzen 7|ryzen 9)\b", title)
    if fallback:
        return format_cpu_match(fallback.group(0))

    return None

# format the cpu value after regex match so Ryzen is capitalised but i7 is not
def format_cpu_match(value):
    value = value.strip().upper()

    if value.startswith("RYZEN"):
        parts = value.split()
        return "Ryzen " + " ".join(parts[1:])

    if value.startswith("I"):
        parts = value.split("I")
        return "i" + "".join(parts[1:])

    return value

def extract_cpu_num(title):
    if not title:
        return None

    title = title.upper()

    match = re.search(r"\b(\d{3,5}[A-Z]{1,2}\d?)\b", title)
    if match:
        return match.group(1)

    match = re.search(r"\b([A-Z]\d{3,5}[A-Z]?)\b", title)
    if match:
        return match.group(1)

    return None


def resolve_cpu_from_title(title, cpu_lookup):
    cpu_num = extract_cpu_num(title)

    if not cpu_num:
        return None

    return cpu_lookup.get(cpu_num.upper())


def cpu_match(title, cpu_lookup, cpu_list):
    # 1. Canonical match (string match against known CPUs)
    found = find_cpu_canon(title, cpu_list)
    if found:
        return found

    # 2. cpu_num lookup (fast dictionary)
    cpu = resolve_cpu_from_title(title, cpu_lookup)
    if cpu:
        return cpu.name

    # 3. pattern fallback
    pattern = find_cpu_pattern(title)
    if pattern:
        return pattern

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
    
    # the smaller value is treated as ram and the larger as storage
    ram = values[0]
    storage = values[-1]

    return ram, storage


#def find_memory(title):
#    title = normalize_title(title)
#
#    matches = list(re.finditer(r"\b(\d+)\s?(mb|gb|tb)\b", title))
#    if not matches:
#        return None, None
#
#    ram = None
#    storage = None
#
#    for m in matches:
#        num = int(m.group(1))
#        unit = m.group(2)
#
#        if unit == "tb":
#            num *= 1024
#        elif unit == "mb":
#            num /= 1024
#
#        span_text = title[max(0, m.start()-10):m.end()+10]
#
#        if any(k in span_text for k in ["ram", "ddr"]):
#            ram = num
#        elif any(k in span_text for k in ["ssd", "hdd", "nvme"]):
#            storage = num
#
#    # fallback if unclear
#    values = sorted([
#        int(m.group(1)) * (1024 if m.group(2) == "tb" else 1)
#        for m in matches
#    ])
#
#    if ram is None and values:
#        ram = values[0]
#
#    if storage is None and len(values) > 1:
#        storage = values[-1]
#
#    return ram, storage

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





"""with app.app_context():
    known_models = {m.name for m in ThinkPadModel.query.all()}
    listings = Listing.query.all()
    #for title in title_list:
        #find_model_near_thinkpad(title, known_models)
        #find_memory(title)
        #print(find_memory(title))
        #print(find_storage_type(title))
        #print(find_cpu_canon(title))
        #print(find_cpu_pattern(title))

    known_models = {m.name for m in ThinkPadModel.query.all()}
    listings = Listing.query.all()

    for listing in listings:
        insert_model_from_title(db.session, listing, known_models)
        find_memory(listing)
        find_storage_type(listing)
        find_cpu_canon(listing)

    db.session.commit()"""
