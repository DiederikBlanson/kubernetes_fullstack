import { Router, Response } from 'express'

const Pool = require('pg').Pool
const pool = new Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST,
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  port: process.env.POSTGRES_PORT,
})

const routes = Router()

routes.get('/', async (_, res: Response) => {
	return res.json({ 
  		message: `Hai, from the server :D (fronturl: ${process.env.FRONTEND_URL})` 
	})
})

routes.get('/products', async (_, res: Response) => {
	try {
		pool.query('SELECT * FROM product', (error: any, results: any) => {
			if (error) {
			  throw error
			}
			return res.json({ 
				result: results.rows
			})
		})
	} catch (e){
		console.log(e)
	}
})

export default routes