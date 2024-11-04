import 'package:flutter/material.dart';
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/fornecedor.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/troca3.dart';

class Troca2 extends StatefulWidget {
  const Troca2({super.key});

  @override
  _Troca2State createState() => _Troca2State();
}

class _Troca2State extends State<Troca2> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // Métodos de navegação
  void _navigateToTela1() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tela1()),
    );
  }

  void _navigateToGastos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Gastos()),
    );
  }

  void _navigateToFornecedor() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Fornecedor()),
    );
  }

  void _navigateToFechamento() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Fechamento()),
    );
  }

  void _navigateToTroca3() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Troca3()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'TROCAS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: _toggleExpansion,
        ),
      ),
      body: Column(
        children: [
          if (_isExpanded)
            Container(
              color: const Color(0xFF20805F),
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton('RELATÓRIO', _navigateToTela1),
                  _buildNavButton('GASTOS', _navigateToGastos),
                  _buildNavButton('FORNECEDOR', _navigateToFornecedor),
                  _buildNavButton('FECHAMENTO', _navigateToFechamento),
                ],
              ),
            ),
          Expanded(
            child: Center(
              child: Column(
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
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: Color(0xFF20805F), width: 2),
                          fixedSize: const Size(100, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 83, 79, 79),
                        ),
                        child: const Text(
                          "TODOS",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildDataTable(),
                  GestureDetector(
                    onTap: _navigateToTroca3,
                    child: _buildDataContainer(),
                  ),
                  _buildTotalRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir os botões de navegação
  Widget _buildNavButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white)),
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
            _buildTableCell("12,00"),
            _buildTableCell("20,00"),
            _buildTableCell("TOTAL"),
            _buildTableCell("HORA"),
          ],
        ),
      ],
    );
  }

  // Método para construir uma célula da tabela
  Widget _buildTableCell(String text) {
    return Container(
      width: 100,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // Método para construir o container de dados
  Widget _buildDataContainer() {
    return Container(
      width: 410,
      height: 300,
      color: const Color.fromARGB(255, 83, 79, 79),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          5,
          (index) => const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              size: 30,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir a linha total
  Widget _buildTotalRow() {
    return Table(
      children: [
        TableRow(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white, width: 2.0)),
            color: Color.fromARGB(255, 83, 79, 79),
          ),
          children: [
            Container(), // Célula vazia
            Container(), // Célula vazia
            Container(), // Célula vazia
            _buildTableCell("TOTAL"),
          ],
        ),
      ],
    );
  }
}
