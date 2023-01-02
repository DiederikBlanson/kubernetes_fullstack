import { Router, Response } from 'express'

const routes = Router()

routes.get('/', (_, res: Response) => res.json({ 
  	message: `Hai, from the server :D (fronturl: ${process.env.FRONTEND_URL})` 
}))

export default routes