import 'package:flutter/material.dart';
import 'package:flutter_application_1/fechamento2.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/fornecedor.dart';
import 'package:flutter_application_1/troca.dart';

class fechamento extends StatefulWidget {
  const fechamento({super.key});

  @override
  _fechamentoState createState() => _fechamentoState();
}

class _fechamentoState extends State<fechamento> {
  bool _isExpanded = false; // Estado para controlar a expansão da AppBar

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded; // Alterna o estado de expansão
    });
  }

   void _navigateToTela1() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tela1()),
    );
  }

  void _navigateToFornecedor() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const fornecedor()),
    );
  }

  void _navigateToGastos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Gastos()),
    );
  }

  void _navigateToTroca() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TROCA()),
    );
  }

  void _navigateToFechamento2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Fechamento2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636), // Cor de fundo igual à Tela1
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0), // Adiciona padding ao título
          child: Text(
            'FECHAMENTO', // Título igual ao da Tela1
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 40,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF20805F), // Cor de fundo igual à Tela1
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
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: _navigateToTela1,
                    child: const Text('RELATÓRIO', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: _navigateToFornecedor,
                    child: const Text('FORNECEDOR', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: _navigateToGastos,
                    child: const Text('GASTOS', style: TextStyle(color: Colors.white)),
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
                    children: [
                      SizedBox(width: 40,),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF20805F), width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          fixedSize: const Size(100, 50),
                          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                        ),
                        child: const Text(
                          "DIA",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(331, 73),
                          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                        ),
                        onPressed: _navigateToFechamento2,
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
                        onPressed: _navigateToFechamento2,
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