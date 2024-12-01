import express from "express";
import cors from "cors";
import db from "./config/database.js"; // Assumindo que a configuração do Sequelize está aqui

import vendasRota from "./routes/vendas_routes.js"; // Rota para as vendas

const server = express();
server.use(express.json());
server.use(cors());


const startServer = async () => {
  try {
    // Tentar autenticar com o banco de dados
    await db.authenticate();
    console.log("Conexão com o MySQL estabelecida");

    // Inicializar o servidor na porta 3001
    server.listen(3001, () =>
      console.log("Servidor executando em http://localhost:3001")
    );
  } catch (e) {
    console.error("Erro ao conectar ao MySQL:", e);
    process.exit(1); // Caso a conexão falhe, o servidor não será iniciado
  }
};

// Adicionar as rotas após a autenticação do banco de dados
server.use(vendasRota);

// Iniciar o servidor e a conexão com o banco
startServer();
