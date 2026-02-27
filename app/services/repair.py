from app.models import Listing, Product
from app.extensions import db
from app.services.model_parser import parse_product_details
from app.services.sync import get_specs
from app import create_app



def repair():
    app = create_app()
    
    with app.app_context():

        MODEL, PROCESSOR, MEMORY, STORAGE = get_specs()

        for listing in Listing.query.all():

            parsed_model, *_ = parse_product_details(
                listing.title,
                "",
                MODEL, PROCESSOR, MEMORY, STORAGE
            )

            if parsed_model == "Unknown":
                continue

            if listing.product.model_name != parsed_model:
                print(f"Fixing {listing.title}")
                print(f"{listing.product.model_name} -> {parsed_model}")

                correct_product = Product.query.filter_by(
                    model_name=parsed_model
                ).first()

                if not correct_product:
                    continue  # or create it if you prefer

                listing.product_id = correct_product.id


        db.session.commit()

if __name__ == "__main__":
    repair()