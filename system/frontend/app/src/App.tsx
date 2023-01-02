import React from 'react'
import './App.css'
import axios from 'axios'

class App extends React.Component {

	state = {
		loading: true,
		list: []
	}

	componentDidMount() {
		axios.get(`${window.REACT_APP_BACKEND_URL}/products`).then((res: any) => {
			this.setState({
				loading: false,
				list: res.data.result
			})
		})
	}

	render(){
		if (this.state.loading) return <div> waiting on server... </div>

		return (
			<div className="App">
				<header className="App-header">
					{
						this.state.list.map((l: any) =>
							<p> Name: {l.name} </p>
						)
					}
				</header>
			</div>
		)
	}
}

export default App
