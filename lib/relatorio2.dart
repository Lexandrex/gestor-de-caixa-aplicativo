import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vendas_service.dart'; // Importe o serviço que já foi criado para fazer a chamada à API


class RELATORIO2 extends StatefulWidget {
  const RELATORIO2({super.key});

  @override
  _RELATORIO2State createState() => _RELATORIO2State();
}

class _RELATORIO2State extends State<RELATORIO2> {
  List<dynamic> vendas = []; // Lista para armazenar os dados de vendas

  @override
  void initState() {
    super.initState();
    _loadVendas(); // Carregar os dados de vendas assim que o widget for inicializado
  }

  // Função para carregar os dados de vendas da API
  Future<void> _loadVendas() async {
    var vendasService = VendasService();
    var fetchedVendas = await vendasService.getVendas();

    setState(() {
      vendas = fetchedVendas; // Atualiza a lista de vendas com os dados retornados
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: const Text(
          'RELATÓRIO',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            "DIA",
            style: TextStyle(fontSize: 40, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              // Ação ao clicar no botão "TODOS"
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF20805F), width: 2),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              fixedSize: const Size(100, 50),
              backgroundColor: const Color.fromARGB(255, 83, 79, 79),
            ),
            child: const Text("TODOS", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 8),
          // Exibe a tabela de vendas
          Expanded(child: _buildDataTable()),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return vendas.isEmpty
        ? const Center(child: CircularProgressIndicator()) // Exibe o indicador de carregamento se os dados estiverem vazios
        : SingleChildScrollView( // Adiciona rolagem na tabela
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(
                color: Colors.white,
                width: 1,
                borderRadius: BorderRadius.circular(4),
              ),
              children: [
                // Cabeçalho da Tabela
                TableRow(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 83, 79, 79),
                  ),
                  children: [
                    _buildTableCell("HORA"),
                    _buildTableCell("12"),
                    _buildTableCell("20"),
                    _buildTableCell("TOTAL"),
                    _buildTableCell("FORMA DE PAGAMENTO"),
                  ],
                ),
                // Preencher a tabela com os dados
                for (var venda in vendas)
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 83, 79, 79),
                    ),
                    children: [
                      _buildTableCell(venda['hora'] ?? 'N/A'), // Garantir que 'hora' não seja null
                      _buildTableCell(venda['quantidade_12']?.toString() ?? '0'), // Tratar null com 0
                      _buildTableCell(venda['quantidade_20']?.toString() ?? '0'), // Tratar null com 0
                      _buildTableCell("R\$ ${venda['total'] ?? '0.00'}"), // Garantir que 'total' não seja null
                      _buildTableCell(venda['formaPagamento'] ?? 'Não Informado'), // Tratar null para 'formaPagamento'
                    ],
                  ),
              ],
            ),
          );
  }

  static Widget _buildTableCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
