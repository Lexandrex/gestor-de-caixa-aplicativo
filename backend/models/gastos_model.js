import { Sequelize } from "sequelize";
import db from "../config/database.js";

const { DataTypes } = Sequelize;

// Definindo o modelo para a tabela 'gastos'
const Gastos = db.define('gastos', {
   id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
   },
   quantidade: {
      type: DataTypes.FLOAT,
      allowNull: false
   },
   date: {
      type: DataTypes.DATE,
      defaultValue: Sequelize.NOW
   },
   descricao: {
      type: DataTypes.TEXT,
      allowNull: true
   }
}, {
   timestamps: false, // Não criar os campos 'createdAt' e 'updatedAt'
   freezeTableName: true // Manter o nome da tabela exatamente como 'gastos'
});

export default Gastos;
