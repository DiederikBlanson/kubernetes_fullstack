
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from sqlalchemy.ext.hybrid import hybrid_property
from sqlalchemy.sql import func


#init my cool db
db = SQLAlchemy()

#init sweet marshmallow
ma=Marshmallow()


# product model class
class Product(db.Model):
    __tablename__ = 'Product'
    ProductID = db.Column(db.Integer, primary_key=True)
    ProductCode = db.Column(db.String(20), unique=True)
    ProductName = db.Column(db.String(200))
    ProductDescription = db.Column(db.String(1000))
    ProductSummary = db.Column(db.Text)
    ProductPrice = db.Column(db.Float)
    ProductVAT = db.Column(db.Float)
    

    def __init__(self, ProductID, ProductCode, ProductName, ProductDescription, ProductSummary, ProductPrice, ProductVAT):
        self.ProductID = ProductID
        self.ProductCode = ProductCode
        self.ProductName = ProductName
        self.ProductDescription = ProductDescription
        self.ProductSummary = ProductSummary
        self.ProductPrice = ProductPrice
        self.ProductVAT = ProductVAT
  

# product review model class
class Review(db.Model):
    __tablename__ = 'Review'
    ReviewID = db.Column(db.Integer, primary_key=True)
    ProductID = db.Column(db.Integer, db.ForeignKey('Product.ProductID'))
    Reviewer = db.Column(db.String(100))
    ReviewPriceQuality = db.Column(db.Integer)
    ReviewSummary = db.Column(db.Text)
    ReviewDescription = db.Column(db.Text)
    ReviewTime = db.Column(db.DateTime, server_default=db.func.now())

    def __init__(self, ProductID, Reviewer, ReviewPriceQuality, ReviewSummary, ReviewDescription):
        self.ProductID = ProductID
        self.Reviewer = Reviewer
        self.ReviewPriceQuality = ReviewPriceQuality
        self.ReviewDescription = ReviewDescription
        self.ReviewSummary = ReviewSummary
        

# Product class Schema to serealize
class ProductSchema(ma.Schema):
  class Meta:
    fields = ('ProductID', 'ProductCode', 'ProductName', 'ProductDescription', 'ProductSummary', 'ProductPrice', 'ProductVAT','AvgReview')

# Product Review class Schema to serealize
class ProductReviewSchema(ma.Schema):
  class Meta:
    fields = ('ReviewID','ProductID', 'Reviewer', 'ReviewPriceQuality', 'ReviewDescription', 'ReviewSummary', 'ReviewTime')

# Initialize the schemas
product_schema = ProductSchema() # for single prodcut
products_schema = ProductSchema(many=True)  # for multiple products
product_review_schema = ProductReviewSchema() # always multiple reviews
product_reviews_schema = ProductReviewSchema(many=True) # always multiple reviews