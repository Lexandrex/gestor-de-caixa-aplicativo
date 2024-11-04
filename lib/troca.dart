import 'package:flutter/material.dart';

class Troca extends StatefulWidget {
  const Troca({super.key});

  @override
  _TrocaState createState() => _TrocaState();
}

class _TrocaState extends State<Troca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: const Text(
          'TROCA',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Ícone de voltar branco
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "DIA",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildDataTable(),
          const SizedBox(height: 8),
          _buildTotalRow(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação ao clicar no botão de edição
          _openEditScreen();
        },
        backgroundColor: const Color(0xFF20805F),
        child: const Icon(Icons.edit,
            color: Colors.white), // Ícone de lápis branco
      ),
    );
  }

  void _openEditScreen() {
    // Navegação ou lógica para abrir a tela de edição
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edição'),
          content: const Text('Aqui você pode editar os dados.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  // Método para construir a tabela de dados
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
