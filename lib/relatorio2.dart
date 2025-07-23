import 'package:flutter/material.dart';

class RELATORIO2 extends StatefulWidget {
  final List<dynamic> vendas; // Lista de vendas do dia
  final String dia; // Data do dia selecionado

  const RELATORIO2({super.key, required this.vendas, required this.dia});

  @override
  // ignore: library_private_types_in_public_api
  _RELATORIO2State createState() => _RELATORIO2State();
}

class _RELATORIO2State extends State<RELATORIO2> {
  @override
  Widget build(BuildContext context) {
    final vendas = widget.vendas;
    final dia = widget.dia;
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
          Text(
            'DIA: ${dia.split('-').reversed.join('/')}',
            style: const TextStyle(fontSize: 32, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildDataTable(vendas)),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<dynamic> vendas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        border: TableBorder.all(
          color: Colors.white,
          width: 1,
          borderRadius: BorderRadius.circular(4),
        ),
        children: [
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
          ...vendas.map((venda) => TableRow(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 83, 79, 79),
            ),
            children: [
              _buildTableCell(venda['hora'] ?? 'N/A'),
              _buildTableCell(venda['quantidade_12']?.toString() ?? '0'),
              _buildTableCell(venda['quantidade_20']?.toString() ?? '0'),
              _buildTableCell("R\$ ${(double.tryParse(venda['total']?.toString() ?? '0') ?? 0).toStringAsFixed(2)}"),
              _buildTableCell(venda['formaPagamento'] ?? 'Não Informado'),
            ],
          )),
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
