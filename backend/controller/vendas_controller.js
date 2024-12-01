import Vendas from "../models/vendas_model.js";

// Função para obter todas as vendas ou filtrar por data específica
export const getVendas = async (req, res) => {
    try {
        const { formaPagamento, date } = req.query;

        const filters = {};

        if (formaPagamento) {
            filters.formaPagamento = formaPagamento;
        }

        if (date) {
            const targetDate = new Date(date);
            targetDate.setHours(0, 0, 0, 0);
            const endOfDay = new Date(targetDate);
            endOfDay.setHours(23, 59, 59, 999);

            filters.data_hora = { [Op.between]: [targetDate, endOfDay] };
        }

        const vendas = await Vendas.findAll({
            where: filters,
            order: [["data_hora", "DESC"]],
        });

        if (!vendas.length) {
            return res.status(404).json({ message: "Nenhuma venda encontrada." });
        }

        res.json(vendas);
    } catch (e) {
        console.error("Erro ao acessar a tabela Vendas:", e.message);
        res.status(500).json({ error: "Erro ao acessar a tabela Vendas, tente novamente mais tarde." });
    }
};

// Função para atualizar uma venda
export const updateVendas = async (req, res) => {
    try {
        const { id_venda } = req.params;
        const { quantidade_12, quantidade_20, formaPagamento, total } = req.body;

        // Encontrar a venda pelo ID
        const venda = await Vendas.findByPk(id_venda);

        if (!venda) {
            return res.status(404).json({ message: "Venda não encontrada." });
        }

        // Atualizar os dados da venda
        venda.quantidade_12 = quantidade_12 || venda.quantidade_12;
        venda.quantidade_20 = quantidade_20 || venda.quantidade_20;
        venda.formaPagamento = formaPagamento || venda.formaPagamento;
        venda.total = total || venda.total;

        // Salvar a venda atualizada
        await venda.save();

        res.json({ message: "Venda atualizada com sucesso.", venda });
    } catch (e) {
        console.error("Erro ao atualizar venda:", e.message);
        res.status(500).json({ error: "Erro ao atualizar a venda, tente novamente mais tarde." });
    }
};

// Função para deletar uma venda
export const deleteVendas = async (req, res) => {
    try {
        const { id_venda } = req.params;

        // Encontrar a venda pelo ID
        const venda = await Vendas.findByPk(id_venda);

        if (!venda) {
            return res.status(404).json({ message: "Venda não encontrada." });
        }

        // Deletar a venda
        await venda.destroy();

        res.json({ message: "Venda deletada com sucesso." });
    } catch (e) {
        console.error("Erro ao deletar venda:", e.message);
        res.status(500).json({ error: "Erro ao deletar a venda, tente novamente mais tarde." });
    }
};
