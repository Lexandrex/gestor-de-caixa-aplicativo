import express from "express";
import { getFornecedor, createFornecedor, updateFornecedor, deleteFornecedor } from "../controller/fornecedor_controller.js";

const router = express.Router();

// Rota para buscar todos os fornecedores ou filtrar por nome ou CNPJ
router.get('/fornecedor', getFornecedor);

// Rota para criar um novo fornecedor
router.post('/fornecedor', createFornecedor);

// Rota para atualizar um fornecedor existente
router.put('/fornecedor/:cnpj', updateFornecedor);

// Rota para deletar um fornecedor
router.delete('/fornecedor/:cnpj', deleteFornecedor);

export default router;
