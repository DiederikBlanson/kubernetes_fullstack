import React from 'react'
import './App.css'
import axios from 'axios'

class App extends React.Component {

	state = {
		message: "Waiting...."
	}

	componentDidMount() {
		console.log(`Backend url: ${window.REACT_APP_BACKEND_URL}`)
		axios.get(window.REACT_APP_BACKEND_URL).then(res => {
			this.setState({
				message: res.data.message
			})
		})
	}

	render(){
		return (
			<div className="App">
				<header className="App-header">
					<p> My message: { this.state.message } </p>
				</header>
			</div>
		)
	}
}

export default App
