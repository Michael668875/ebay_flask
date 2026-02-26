from app.models import ThinkPadModel, CPU, RAM, Storage
import re

def get_specs():
    MODEL = [m.name for m in ThinkPadModel.query.all()]
    PROCESSOR = [c.name for c in CPU.query.all()]
    MEMORY = [r.size for r in RAM.query.all()]
    STORAGE = [s.size for s in Storage.query.all()]
    return MODEL, PROCESSOR, MEMORY, STORAGE

def parse_product_details(title: str, short_description: str = ""):
    title_lower = f"{title} {short_description}".lower()

    MODEL, PROCESSOR, MEMORY, STORAGE = get_specs()

    # Model
    model = max((m for m in MODEL if m.lower() in title_lower), key=len, default="Unknown")

    # CPU
    cpu = next((c for c in PROCESSOR if c.lower() in title_lower), "Unknown")

    # Detect CPU frequency (e.g., 2.6GHz, 2.60 GHz)
    cpu_freq_match = re.search(r'(\d+(\.\d+)?\s?ghz)', title_lower)
    cpu_freq = cpu_freq_match.group(1) if cpu_freq_match else ""

    # RAM
    ram = next((r for r in MEMORY if r.lower() in title_lower), "Unknown")

    # Storage
    storage = next((s for s in STORAGE if s.lower().replace(" ", "") in title_lower.replace(" ", "")), "Unknown")

    # Detect storage type
    if "nvme" in title_lower:
        storage_type = "NVME"
    elif "ssd" in title_lower:
        storage_type = "SSD"
    elif "hdd" in title_lower or "hard drive" in title_lower:
        storage_type = "HDD"
    else:
        storage_type = ""

    return model, cpu, cpu_freq, ram, storage, storage_type

