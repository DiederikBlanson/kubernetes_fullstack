import express from 'express'
import routes from './routes'
import cors from 'cors'
import dotenv from 'dotenv'

dotenv.config()

class App {
	public server

	constructor(){
		this.server = express()
		this.middlewares()
		this.cors()
		this.routes()
	}

	cors = () => {
		this.server.use(cors({
			origin: process.env.FRONTEND_URL, 
			credentials: true
		}))
	}

	middlewares = () => {
		this.server.use(express.json())
	}

	routes = () => {
		this.server.use(routes)
	}
}

export default (new App().server).listen(process.env.PORT) 
