import 'package:flutter/material.dart';

class RELATORIO2 extends StatefulWidget {
  final dynamic venda; // A venda que foi passada da Tela1

  const RELATORIO2({super.key, required this.venda}); // Recebe a venda no construtor

  @override
  _RELATORIO2State createState() => _RELATORIO2State();
}

class _RELATORIO2State extends State<RELATORIO2> {
  @override
  Widget build(BuildContext context) {
    var venda = widget.venda; // Acessa a venda recebida

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
            Navigator.pop(context); // Retorna para a Tela1
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
          const SizedBox(height: 8),
          // Tabela com os dados da venda
          Expanded(child: _buildDataTable(venda)),
        ],
      ),
    );
  }

  Widget _buildDataTable(dynamic venda) {
    return SingleChildScrollView(
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
          TableRow(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 83, 79, 79),
            ),
            children: [
              _buildTableCell(venda['hora'] ?? 'N/A'), // Hora
              _buildTableCell(venda['quantidade_12']?.toString() ?? '0'), // 12
              _buildTableCell(venda['quantidade_20']?.toString() ?? '0'), // 20
              _buildTableCell("R\$ ${(double.tryParse(venda['total']?.toString() ?? '0') ?? 0).toStringAsFixed(2)}"), // Total
              _buildTableCell(venda['formaPagamento'] ?? 'Não Informado'), // Forma de pagamento
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
