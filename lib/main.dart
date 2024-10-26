import 'package:flutter/material.dart';
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/fornecedor.dart';
import 'package:flutter_application_1/relatorio2.dart';
import 'package:flutter_application_1/troca.dart';

void main() => runApp(const Atividade());

class Atividade extends StatelessWidget {
  const Atividade({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Atividade',
      home: Tela1(), // Define a Tela1 como a tela inicial
    );
  }
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  _Tela1State createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
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

  void _navigateToRelatorio2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RELATORIO2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: const Text(
          'RELATÓRIO',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 40,
          ),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: _toggleExpansion, // Chama a função ao clicar no ícone
        ),
      ),
      body: Column(
        children: [
          if (_isExpanded) // Exibe as opções se estiver expandido
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
                  const Text(
                    "ANO",
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "MÊS",
                        style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(331, 73),
                          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                        ),
                        onPressed: _navigateToRelatorio2,
                        child: null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(331, 73),
                          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                        ),
                        onPressed: _navigateToRelatorio2,
                        child: null,
                      ),
                    ],
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