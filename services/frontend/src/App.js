import React from 'react' 
import Products from './pages/Products'
import Product from './pages/Product'
import { Switch, Route } from 'react-router-dom'
import './all.css'
import './products.css'
import './product.css'

class Component extends React.Component {
    render(){
        return <Switch>
            <Route exact path="/" component={Products} />
            <Route path="/product/:id" component={Product} />
        </Switch>
    }
}

export default Component