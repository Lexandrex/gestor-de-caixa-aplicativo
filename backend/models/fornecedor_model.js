import { Sequelize } from "sequelize";
import db from "../config/database.js";

const { DataTypes } = Sequelize;

// Definindo o modelo para a tabela 'Fornecedor'
const Fornecedor = db.define('fornecedor', {
   cnpj: {
      type: DataTypes.STRING,
      primaryKey: true
   },
   nome: {
      type: DataTypes.STRING,
      allowNull: false
   },
   telefone: {
      type: DataTypes.STRING,
      allowNull: true
   },
   descricao: {
      type: DataTypes.TEXT,
      allowNull: true
   }
}, {
   timestamps: false, // Não criar os campos 'createdAt' e 'updatedAt'
   freezeTableName: true // Manter o nome da tabela exatamente como 'Fornecedor'
});

export default Fornecedor;
