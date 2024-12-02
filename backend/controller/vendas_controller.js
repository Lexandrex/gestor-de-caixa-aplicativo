import Vendas from "../models/vendas_model.js";

export const getVendas = async (req, res) => {
    try {
        // Buscando todas as vendas na tabela 'Vendas'
        const vendas = await Vendas.findAll(); // Renomeado para evitar conflito
        console.log(vendas)
        res.json(vendas); // Retorna todas as vendas em formato JSON
    } catch (e) {
        console.error("Erro ao acessar a tabela Vendas:", e);
        res.status(500).json({ error: "Erro ao acessar a tabela Vendas" });
    }
};
