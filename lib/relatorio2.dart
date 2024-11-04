import 'package:flutter/material.dart';

class RELATORIO2 extends StatelessWidget {
  const RELATORIO2({super.key});

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
          _buildDataTable(),
          const SizedBox(height: 8),
          _buildTotalRow(),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Table(
      children: [
        TableRow(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 2.0)),
            color: Color.fromARGB(255, 83, 79, 79),
          ),
          children: [
            _buildTableCell("HORA"),
            _buildTableCell("12"),
            _buildTableCell("20"),
            _buildTableCell("TOTAL"),
          ],
        ),
        // Exemplo de dados; você pode substituir ou adicionar mais conforme necessário.
        TableRow(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 2.0)),
            color: Color.fromARGB(255, 83, 79, 79),
          ),
          children: [
            _buildTableCell("10:00"),
            _buildTableCell("1"),
            _buildTableCell("2"),
            _buildTableCell("R\$ 52,00"),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 2.0)),
            color: Color.fromARGB(255, 83, 79, 79),
          ),
          children: [
            _buildTableCell("11:00"),
            _buildTableCell("3"),
            _buildTableCell("1"),
            _buildTableCell("R\$ 42,00"),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 2.0)),
            color: Color.fromARGB(255, 83, 79, 79),
          ),
          children: [
            _buildTableCell("12:00"),
            _buildTableCell("0"),
            _buildTableCell("5"),
            _buildTableCell("R\$ 100,00"),
          ],
        ),
      ],
    );
  }

  static Widget _buildTableCell(String text) {
    return Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildTotalRow() {
    int totalQuantidade12 = 1 + 3 + 0;
    int totalQuantidade20 = 2 + 1 + 5;
    int totalGeral = (totalQuantidade12 * 12) + (totalQuantidade20 * 20);

    return Table(
      children: [
        TableRow(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white, width: 2.0)),
            color: Color.fromARGB(255, 83, 79, 79),
          ),
          children: [
            _buildTableCell("TOTAL"),
            _buildTableCell(totalQuantidade12.toString()),
            _buildTableCell(totalQuantidade20.toString()),
            _buildTableCell(
                "R\$ ${totalGeral.toStringAsFixed(2).replaceAll('.', ',')}"),
          ],
        ),
      ],
    );
  }
}
