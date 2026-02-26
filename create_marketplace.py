# seed_db.py
import os
from app import create_app
from app.extensions import db
from app.models import ThinkPadModel, CPU, RAM, Storage

# ==== Setup Flask app context ====
app = create_app()
app.app_context().push()  # push the context so db.session works

# ==== Paths to your .txt files ====
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "app", "data")  # adjust if your data folder is somewhere else

MODEL_FILE_PATH = os.path.join(DATA_DIR, "thinkpad_models.txt")
CPU_FILE_PATH = os.path.join(DATA_DIR, "cpu_list.txt")
RAM_FILE_PATH = os.path.join(DATA_DIR, "ram_sizes.txt")
SSD_FILE_PATH = os.path.join(DATA_DIR, "storage_sizes.txt")

# ==== Helper functions ====
def load_file(filepath):
    """Load a txt file, strip lines, ignore empty ones."""
    with open(filepath, "r", encoding="utf-8") as f:
        return [line.strip() for line in f if line.strip()]

def seed_table(model_class, values, column_name="name"):
    """Add values to table if they don't exist."""
    for val in values:
        filter_args = {column_name: val}
        if not model_class.query.filter_by(**filter_args).first():
            db.session.add(model_class(**filter_args))
    db.session.commit()

# ==== Load data from files ====
models = load_file(MODEL_FILE_PATH)
cpu = load_file(CPU_FILE_PATH)
ram = load_file(RAM_FILE_PATH)
storage = load_file(SSD_FILE_PATH)

# ==== Seed tables ====
seed_table(ThinkPadModel, models, column_name="name")
seed_table(CPU, cpu, column_name="name")
seed_table(RAM, ram, column_name="size")
seed_table(Storage, storage, column_name="size")

print("✅ Successfully seeded all tables!")