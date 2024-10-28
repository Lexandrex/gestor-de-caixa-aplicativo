import 'package:flutter/material.dart';
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/fornecedor.dart';
import 'package:flutter_application_1/troca.dart';

class Fechamento2 extends StatefulWidget {
  const Fechamento2({super.key});

  @override
  _Fechamento2State createState() => _Fechamento2State();
}

class _Fechamento2State extends State<Fechamento2> {
  bool _isExpanded = false; // Estado para controlar a expansão da AppBar

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded; // Alterna o estado de expansão
    });
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

  void _navigateToTroca() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TROCA()),
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
            'RELATÓRIO',
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  TextButton(
                    onPressed: _navigateToTroca,
                    child: const Text('TROCA', style: TextStyle(color: Colors.white)),
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
                  Container(
                    width: 300,
                    height: 300,
                    color: const Color.fromARGB(255, 83, 79, 79),
                    alignment: Alignment.bottomCenter,
                      child: Table(
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.white, width: 2.0)),
                          color: Color.fromARGB(255, 83, 79, 79),
                        ),
                        children: [
                          Container(   
                            width: 10,                      
                            height: 50,
                            alignment: Alignment.center,
                            child: null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}