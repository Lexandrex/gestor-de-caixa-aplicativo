import express from "express";
import { getVendas, updateVendas, deleteVendas } from "../controller/vendas_controller.js";

const router = express.Router();

// Rota para buscar vendas com filtros
router.get('/vendas', getVendas);

// Rota para atualizar uma venda
router.put('/vendas/:id_venda', updateVendas);

// Rota para deletar uma venda
router.delete('/vendas/:id_venda', deleteVendas);

export default router;
