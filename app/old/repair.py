from app.models import Listing, Product
from app.extensions import db
from app.services.model_parser import parse_product_details
from app.services.sync import get_specs
from app import create_app



def repair():
    app = create_app()
    with app.app_context():
        MODEL, PROCESSOR, MEMORY, STORAGE = get_specs()

        # Ensure there is an "Unknown" product
        unknown_product = Product.query.filter_by(model_name="Unknown").first()
        if not unknown_product:
            unknown_product = Product(model_name="Unknown")
            db.session.add(unknown_product)
            db.session.flush()

        for listing in Listing.query.all():
            parsed_model, *_ = parse_product_details(
                listing.title,
                "",
                MODEL, PROCESSOR, MEMORY, STORAGE
            )

            print("TITLE:", listing.title)
            print("PARSED MODEL:", parsed_model)
            print("CURRENT PRODUCT:", listing.product.model_name)

            if parsed_model == "Unknown":
                if listing.product.model_name != "Unknown":
                    listing.product = unknown_product
                    db.session.flush()
                    db.session.refresh(listing)
                    print("UPDATED TO UNKNOWN:", listing.title)
                continue

            correct_product = Product.query.filter_by(model_name=parsed_model).first()
            if not correct_product:
                correct_product = Product(model_name=parsed_model)
                db.session.add(correct_product)
                db.session.flush()  # get ID

            if listing.product_id != correct_product.id:
                listing.product = correct_product
                db.session.flush()
                db.session.refresh(listing)
                print("UPDATED:", listing.title, "->", parsed_model)

        db.session.commit()
        
                
if __name__ == "__main__":
    repair()