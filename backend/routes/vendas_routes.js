import express from "express"

import { getVendas } from "../controller/vendas_controller.js"

const router = express.Router()

router.get('/vendas', getVendas)


export default router