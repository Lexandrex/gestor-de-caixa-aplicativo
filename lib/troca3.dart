import 'package:flutter/material.dart';
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/fornecedor.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/gastos.dart';

class Troca3 extends StatefulWidget {
  const Troca3({super.key});

  @override
  _Troca3State createState() => _Troca3State();
}

class _Troca3State extends State<Troca3> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

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
      MaterialPageRoute(builder: (context) => const fornecedor()),
    );
  }

  void _navigateToFechamento() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const fechamento()),
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
                  TextButton(
                    onPressed: _navigateToTela1,
                    child: const Text('RELATÓRIO', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: _navigateToGastos,
                    child: const Text('GASTOS', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: _navigateToFornecedor,
                    child: const Text('FORNECEDOR', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: _navigateToFechamento,
                    child: const Text('FECHAMENTO', style: TextStyle(color: Colors.white)),
                  ),
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
                  const SizedBox(height: 8),
                  Table (
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white, width: 2.0)),
                          color: Color.fromARGB(255, 83, 79, 79),
                        ),
                        children: [
                          Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text("12,00", style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text("20,00", style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text("TOTAL", style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text("HORA", style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                 Container(
                    width: 410,
                    height: 150,
                     alignment: Alignment.center,
                    color: const Color.fromARGB(255, 83, 79, 79),
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            Center(child: Text('0', style: const TextStyle(color: Colors.white, fontSize: 20))),
                            Center(child: Text('0', style: const TextStyle(color: Colors.white, fontSize: 20))),
                            Center(child: Text('00', style: const TextStyle(color: Colors.white, fontSize: 20))),
                            Container(width: 200, height: 50),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}