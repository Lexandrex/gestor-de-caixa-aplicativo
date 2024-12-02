import { Sequelize } from 'sequelize';
import Fornecedor from "../models/fornecedor_model.js";

// Função para obter todos os fornecedores ou filtrar por nome ou CNPJ
export const getFornecedor = async (req, res) => {
    try {
        const { nome, cnpj } = req.query;

        const filters = {};

        if (nome) {
            filters.nome = { [Op.iLike]: `%${nome}%` }; // Busca insensível a maiúsculas e minúsculas
        }

        if (cnpj) {
            filters.cnpj = cnpj;
        }

        const fornecedores = await Fornecedor.findAll({
            where: filters,
            order: [["nome", "ASC"]], // Ordena por nome de forma crescente
        });

        if (!fornecedores.length) {
            return res.status(404).json({ message: "Nenhum fornecedor encontrado." });
        }

        res.json(fornecedores);
    } catch (e) {
        console.error("Erro ao acessar a tabela Fornecedores:", e.message);
        res.status(500).json({ error: "Erro ao acessar a tabela Fornecedores, tente novamente mais tarde." });
    }
};

// Função para criar um novo fornecedor
export const createFornecedor = async (req, res) => {
    try {
        const { cnpj, nome, telefone, descricao } = req.body;

        if (!cnpj || !nome) {
            return res.status(400).json({ error: "CNPJ e Nome são obrigatórios." });
        }

        const fornecedor = await Fornecedor.create({
            cnpj,
            nome,
            telefone,
            descricao,
        });

        res.status(201).json({ message: "Fornecedor criado com sucesso.", fornecedor });
    } catch (e) {
        console.error("Erro ao criar fornecedor:", e.message);
        res.status(500).json({ error: "Erro ao criar o fornecedor, tente novamente mais tarde." });
    }
};

// Função para atualizar um fornecedor existente
export const updateFornecedor = async (req, res) => {
    try {
        const { cnpj } = req.params;
        const { nome, telefone, descricao } = req.body;

        const fornecedor = await Fornecedor.findByPk(cnpj);

        if (!fornecedor) {
            return res.status(404).json({ message: "Fornecedor não encontrado." });
        }

        fornecedor.nome = nome || fornecedor.nome;
        fornecedor.telefone = telefone || fornecedor.telefone;
        fornecedor.descricao = descricao || fornecedor.descricao;

        await fornecedor.save();

        res.json({ message: "Fornecedor atualizado com sucesso.", fornecedor });
    } catch (e) {
        console.error("Erro ao atualizar fornecedor:", e.message);
        res.status(500).json({ error: "Erro ao atualizar o fornecedor, tente novamente mais tarde." });
    }
};

// Função para deletar um fornecedor
export const deleteFornecedor = async (req, res) => {
    try {
        const { cnpj } = req.params;

        const fornecedor = await Fornecedor.findByPk(cnpj);

        if (!fornecedor) {
            return res.status(404).json({ message: "Fornecedor não encontrado." });
        }

        await fornecedor.destroy();

        res.json({ message: "Fornecedor deletado com sucesso." });
    } catch (e) {
        console.error("Erro ao deletar fornecedor:", e.message);
        res.status(500).json({ error: "Erro ao deletar o fornecedor, tente novamente mais tarde." });
    }
};
