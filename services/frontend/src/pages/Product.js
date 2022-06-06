import React from 'react'
import axios from 'axios'

const getTime = (input) => { 
    const date = new Date(input)
    var year = date.getFullYear(),
    month = date.getMonth() + 1, 
    day = date.getDate(),
    hour = date.getHours(),
    minute = date.getMinutes(),
    second = date.getSeconds()
    return `${day}-${month}-${year} ${hour}:${minute}:${second}`
}

class Component extends React.Component {

    state = {
        isLoading: true,
        productInfo: {},
        NUMBER_OF_RATINGS: 10,
        rating: 6,
        reviewerName: "",
        reviewShort: "",
        reviewDescription: ""
    }

    addReview = (input) => { 
        axios.post(`${window.REACT_APP_BACKEND_URL}/review`, {
            ProductID: this.state.productInfo.ProductID,
            ReviewPriceQuality: this.state.rating,
            Reviewer: this.state.reviewerName || "Anonymous",
            ReviewSummary: this.state.reviewShort,
            ReviewDescription: this.state.reviewDescription
        }).then(response => { 
           var reviews = this.state.productInfo.reviews
           reviews.push(response.data) 
           this.setState({
               reviews,
               reviewerName: "",
               reviewShort: "",
               reviewDescription: ""
           })
        }).catch(error => console.error(error))
    }

    setValue = (key, value) => {
        this.setState({
            [key]: value
        })
    }

    deleteReview = (id) => { 
        axios.post(`${window.REACT_APP_BACKEND_URL}/review-delete`, {
            ReviewID: id
        }).then(() => { 
            var reviews = this.state.productInfo.reviews
            reviews = reviews.filter(review => review.ReviewID != id)
            this.setState(prevState => ({
                ...prevState,
                productInfo: {
                    ...prevState.productInfo,
                    reviews
                }
            }))
        }).catch(error => console.error(error))
    }

    componentDidMount(){
        const { id} = this.props.match.params
        axios.get(`${window.REACT_APP_BACKEND_URL}/product/${id}`).then(productInfo => {
            axios.get(`${window.REACT_APP_BACKEND_URL}/product/${id}/reviews`).then(reviews => {
                this.setState({
                    isLoading: false,
                    productInfo: {
                        ...productInfo.data,
                        reviews: reviews.data
                    }
                })
            }).catch(error => console.error(error)) 
        }).catch(error => console.error(error)) 
    }

    render(){
        if (this.state.isLoading) return <div className="loader"></div>
        const { productInfo } = this.state

        return <div id="page_product">
            <div className="product-information">
                <div className="left" style={{backgroundImage: `url(/assets/product-cover-${productInfo.ProductID}.png)`}}></div>
                <div className="right">
                    <div className="inner">
                        <h1 className='title'> {productInfo.ProductName} </h1>
                        <h5 className="price"> Starting from ${productInfo.ProductPrice} </h5>
                        <div className='stars'> 
                            { Array.from(Array(productInfo.AvgReview).keys()).map((star, j) => {
                                    return <img key={j} className='star' src='/assets/star.png' />
                                })
                            } 
                        </div>
                        <h4 className='description'> {productInfo.ProductDescription} </h4>
                    </div>
                </div>
            </div>
            <div className="product-reviews">
                <h1> Reviews </h1>
                <div className="reviews">
                    {
                        productInfo.reviews.length == 0 ? `There are no reviews written yet. Below you can add a review about '${productInfo.ProductName}'.` :
                        productInfo.reviews.sort((a, b) => (a.ReviewTime < b.ReviewTime) ? 1 : -1).map((review, i) => { 
                            return <div className="review" key={i}>
                                <div className="profile-picture" style={{backgroundImage: `url(/assets/dummy-profile-picture.png`}}> </div>
                                <div className="user"> 
                                    <h3> {review.Reviewer} </h3>
                                    <h5 className="date"> {getTime(review.ReviewTime)} </h5> 
                                </div>
                                <h3 className='summary'> {review.ReviewSummary} </h3>
                                <h4 className='rating'> {review.ReviewPriceQuality}/{this.state.NUMBER_OF_RATINGS} </h4>
                                <h4 className='description'> {review.ReviewDescription} </h4>
                                <span className="button delete" onClick={() => this.deleteReview(review.ReviewID)}> DELETE </span>
                            </div>
                        })
                    }
                </div>
            </div>
            <div className="product-review-add">
                <h2> Add review </h2>
                <input type="text" className="add-review-user" value={this.state.reviewerName} onChange={(e) => this.setValue('reviewerName', e.target.value)} placeholder="Your name"/>
                    Rating <select className="add-review-rating" value={this.state.rating} onChange={(e) => this.setValue('rating', e.target.value)}>
                    {
                        Array.from(Array(this.state.NUMBER_OF_RATINGS).keys()).map((star, j) => {
                            var rating = j + 1
                            return <option value={rating} key={j}> { rating } </option>
                        })
                    }
                </select>
                <textarea className="add-review-summary" value={this.state.reviewShort} onChange={(e) => this.setValue('reviewShort', e.target.value)} placeholder="Short description"></textarea>
                <textarea className="add-review-description" value={this.state.reviewDescription} onChange={(e) => this.setValue('reviewDescription', e.target.value)}  placeholder="Enter review"></textarea>
                <span className="button add" onClick={() => this.addReview()}> ADD </span>
            </div>
        </div>
    }
}

export default Component