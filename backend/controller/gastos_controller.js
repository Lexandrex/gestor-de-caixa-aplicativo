import { Sequelize, Op } from 'sequelize';
import Gastos from "../models/gastos_model.js";

// Função para obter todos os gastos ou filtrar por data
export const getGastos = async (req, res) => {
    try {
        const { startDate, endDate } = req.query;

        const filters = {};

        if (startDate && endDate) {
            filters.date = { [Op.between]: [new Date(startDate), new Date(endDate)] };
        }

        // Busca no banco de dados com filtros
        const gastos = await Gastos.findAll({
            where: filters,
            order: [["date", "DESC"]],
        });

        if (!gastos.length) {
            return res.status(404).json({ message: "Nenhum gasto encontrado." });
        }

        res.json(gastos);
    } catch (e) {
        console.error("Erro ao acessar a tabela Gastos:", e.message);
        res.status(500).json({ error: "Erro ao acessar a tabela Gastos, tente novamente mais tarde." });
    }
};

export const getSomaGastos = async (req, res) => {
    try {
        // Não há mais filtros de data
        const result = await Gastos.sum('quantidade'); // Soma diretamente a coluna "quantidade" dos gastos

        if (result === null) {
            return res.status(404).json({ message: "Nenhum gasto encontrado." });
        }

        // Retorna a soma dos gastos
        res.json({ soma: result });
    } catch (e) {
        console.error("Erro ao acessar a tabela Gastos:", e.message);
        res.status(500).json({ error: "Erro ao acessar a tabela Gastos, tente novamente mais tarde." });
    }
};

// Função para criar um novo gasto
export const createGasto = async (req, res) => {
    try {
        console.log("Corpo da requisição recebido:", req.body); // Log 1
        const novoGasto = await Gastos.create(req.body); // Definição correta da variável
        console.log("Gasto criado:", novoGasto); // Log 2
        res.json({ message: "Gasto criado com sucesso.", gasto: novoGasto });
    } catch (e) {
        console.error("Erro ao criar gasto11:", e); // Log 3
        res.status(500).json({ error: "Erro ao criar o gasto, tente novamente mais tarde." });
    }
};



// Função para atualizar um gasto existente
export const updateGasto = async (req, res) => {
    try {
        const { id } = req.params;
        const { quantidade, descricao, date } = req.body;

        const gasto = await Gastos.findByPk(id);

        if (!gasto) {
            return res.status(404).json({ message: "Gasto não encontrado." });
        }

        gasto.quantidade = quantidade || gasto.quantidade;
        gasto.descricao = descricao || gasto.descricao;
        gasto.date = date || gasto.date;

        await gasto.save();

        res.json({ message: "Gasto atualizado com sucesso.", gasto });
    } catch (e) {
        console.error("Erro ao atualizar gasto:", e.message);
        res.status(500).json({ error: "Erro ao atualizar o gasto, tente novamente mais tarde." });
    }
};

// Função para deletar um gasto
export const deleteGasto = async (req, res) => {
    try {
        const { id } = req.params;

        const gasto = await Gastos.findByPk(id);

        if (!gasto) {
            return res.status(404).json({ message: "Gasto não encontrado." });
        }

        await gasto.destroy();

        res.json({ message: "Gasto deletado com sucesso." });
    } catch (e) {
        console.error("Erro ao deletar gasto:", e.message);
        res.status(500).json({ error: "Erro ao deletar o gasto, tente novamente mais tarde." });
    }
};
