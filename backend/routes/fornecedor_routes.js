import express from "express";
import { getFornecedores, createFornecedor, updateFornecedor, deleteFornecedor } from "../controller/fornecedor_controller.js";

const router = express.Router();

// Rota para buscar todos os fornecedores ou filtrar por nome ou CNPJ
router.get('/fornecedores', getFornecedores);

// Rota para criar um novo fornecedor
router.post('/fornecedores', createFornecedor);

// Rota para atualizar um fornecedor existente
router.put('/fornecedores/:cnpj', updateFornecedor);

// Rota para deletar um fornecedor
router.delete('/fornecedores/:cnpj', deleteFornecedor);

export default router;
