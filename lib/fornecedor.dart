import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/troca.dart';
import 'package:flutter_application_1/fornecedor2.dart';

class fornecedor extends StatefulWidget {
  const fornecedor({super.key});

  @override
  _fornecedorState createState() => _fornecedorState();
}

class _fornecedorState extends State<fornecedor> {
  bool _isExpanded = false; // Estado para controlar a expansão da AppBar

  // Função para alternar a expansão da AppBar
  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded; // Alterna o estado de expansão
    });
  }

  // Funções para navegação entre telas
  void _navigateToTela1() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tela1()),
    );
  }

  void _navigateToFechamento() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const fechamento()),
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

  void _navigateToFornecedor2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Fornecedor2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636), // Cor de fundo
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0), // Adiciona padding ao título
          child: Text(
            'FORNECEDOR', // Título da AppBar
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 40,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF20805F), // Cor de fundo da AppBar
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
                    onPressed: _navigateToFechamento,
                    child: const Text('FECHAMENTO', style: TextStyle(color: Colors.white)),
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
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 20),
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
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(8.0)),
                  // Row para colocar o círculo ao lado do botão
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Círculo
                      Container(
                        width: 75, // Largura do círculo
                        height: 75, // Altura do círculo
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF20805F), width: 2
                          ),
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 83, 79, 79), // Cor do círculo
                        ),
                        child: const Icon(Icons.person),
                      ),
                      const SizedBox(width: 20), // Espaçamento entre o círculo e o botão
                      // Botão
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(280, 73),
                          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              bottomLeft: Radius.circular(0.0),
                              topRight: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                            ),
                          ),
                        ),
                        onPressed: _navigateToFornecedor2, // Ação do botão
                        child: const Text(''), // Texto do botão
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