import re

def parse_specs(title: str):
    specs = {}

    # CPU
    cpu = re.search(r'i[3579]-\d{4,5}[a-zA-Z]*', title)
    if cpu:
        specs["cpu"] = cpu.group(0)

    # RAM
    ram = re.search(r'(\d{1,2})\s?GB\s?RAM', title, re.I)
    if ram:
        specs["ram"] = int(ram.group(1))

    # Storage
    storage = re.search(r'(\d{3,4})\s?(GB|TB)\s?(SSD|HDD)', title, re.I)
    if storage:
        specs["storage"] = storage.group(0)

    # Screen size
    screen = re.search(r'(1[2-6]\.\d)"', title)
    if screen:
        specs["screen"] = screen.group(1)

    # Resolution
    if "FHD" in title.upper():
        specs["resolution"] = "1920x1080"

    if "4K" in title.upper():
        specs["resolution"] = "3840x2160"

    # GPU
    gpu = re.search(r'(RTX\s?\d{3,4}|GTX\s?\d{3,4}|MX\d{3})', title, re.I)
    if gpu:
        specs["gpu"] = gpu.group(0)

    return specs