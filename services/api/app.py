from flask import Flask, jsonify, request, redirect
import os
from flask_cors import CORS
from sqlalchemy.sql import func

from dbmodel import db, Review, Product, products_schema, product_schema, product_reviews_schema, product_review_schema


app = Flask(__name__, instance_relative_config=True)


CORS(app, resources={r"/*": {"origins": ("%s" % os.environ.get("FRONTEND_URL"))}})


app.config.from_mapping(
    SECRET_KEY=os.environ.get("SECRET_KEY"),
    SQLALCHEMY_DATABASE_URI=os.environ.get("SQLALCHEMY_DATABASE_URI"),
    SQLALCHEMY_TRACK_MODIFICATIONS=False
)

db.app = app
db.init_app(app)
db.create_all()

# all endpoints

# list all the products
@app.route('/products' , methods=['GET'])
def get_products():
    products = Product.query.all()
    result = products_schema.dump(products)
    data = []
    for item in result:
        item["AvgReview"] = 0 # default if no review present
        if len(Review.query.filter(Review.ProductID==item["ProductID"]).all()) > 0:
            avg = Review.query.with_entities(func.avg(Review.ReviewPriceQuality)).filter(Review.ProductID==item["ProductID"]).scalar()
            item["AvgReview"] = round((float(avg)/2),0) # covert string to float e.g. 2.0
        data.append(item)
    return jsonify(data)


# get product details for a single product id
@app.route('/product/<ProductID>' , methods=['GET'])
def get_product(ProductID):
    product = Product.query.get(ProductID)
    result = product_schema.dump(product)
    result["AvgReview"] = 0 # default if no review present
    if len(Review.query.filter(Review.ProductID==result["ProductID"]).all()) > 0:
        avg = Review.query.with_entities(func.avg(Review.ReviewPriceQuality)).filter(Review.ProductID==result["ProductID"]).scalar()
        result["AvgReview"] = round((float(avg)/2),0) # covert string to float e.g. 2.0
    return jsonify(result)


# get product reviews for a single product id
@app.route('/product/<ProductID>/reviews' , methods=['GET'])
def get_productreviews(ProductID):
    reviews = Review.query.filter_by(ProductID=ProductID).all()
    result = product_reviews_schema.dump(reviews)
    return jsonify(result)


# Create a Product
@app.route('/product', methods=['POST'])
def new_product():
    ProductID = request.json['ProductID']
    ProductCode = request.json['ProductCode']
    ProductName = request.json['ProductName']
    ProductDescription = request.json['ProductDescription']
    ProductSummary = request.json['ProductSummary']
    ProductPrice = request.json['ProductPrice']
    ProductVAT = request.json['ProductVAT']
    new_product = Product(ProductID, ProductCode,ProductName, ProductDescription, ProductSummary, ProductPrice, ProductVAT)
    db.session.add(new_product)
    db.session.commit()
    return product_schema.jsonify(new_product)


# Create a review for a Product
@app.route('/review', methods=['POST'])
def new_product_review():
    ProductID = request.json['ProductID']
    Reviewer = request.json['Reviewer']
    ReviewPriceQuality = request.json['ReviewPriceQuality']
    ReviewSummary = request.json['ReviewSummary']
    ReviewDescription = request.json['ReviewDescription']
    new_product_review = Review(ProductID, Reviewer, ReviewPriceQuality, ReviewSummary, ReviewDescription)
    db.session.add(new_product_review)
    db.session.commit()
    return product_review_schema.jsonify(new_product_review)


# delete a review for a Product
@app.route('/review-delete', methods=['POST'])
def delete_product_review():
    reviewid = request.json['ReviewID']
    review = Review.query.get(reviewid)
    db.session.delete(review)
    db.session.commit()
    return product_review_schema.jsonify(review)


@app.before_request
def before_request():
    if not request.is_secure:
        url = request.url.replace('http://', 'https://', 1)
        return redirect(url)



if __name__=="__main__":
    app.run(ssl_context=('cert.pem', 'key.pem'), host='0.0.0.0')