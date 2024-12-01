import express from "express";
import { getGastos, createGasto, updateGasto, deleteGasto } from "../controller/gastos_controller.js";

const router = express.Router();

// Rota para buscar todos os gastos ou filtrar por data
router.get('/gastos', getGastos);

// Rota para criar um novo gasto
router.post('/gastos', createGasto);

// Rota para atualizar um gasto existente
router.put('/gastos/:id', updateGasto);

// Rota para deletar um gasto
router.delete('/gastos/:id', deleteGasto);

export default router;
