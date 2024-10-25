import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/gastos.dart';

class fornecedor extends StatefulWidget {
  const fornecedor({super.key});

  @override
  _fornecedorState createState() => _fornecedorState();
}

class _fornecedorState extends State<fornecedor> {
  bool _isExpanded = false; // Estado para controlar a expansão da AppBar

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded; // Alterna o estado de expansão
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636), // Cor de fundo igual à Tela1
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0), // Adiciona padding ao título
          child: Text(
            'FORNECEDOR', // Título igual ao da Tela1
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
              padding: const EdgeInsets.all(8.0), // Padding ao redor do Container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Tela1()),
                    ), // Ação da Opção 1
                    child: const Text('RELATÓRIO', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Gastos()),
                    ), // Ação da Opção 2
                    child: const Text('GASTOS', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {}, // Ação da Opção 3
                    child: const Text('FORNECEDOR', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                   Padding(padding: EdgeInsets.all(8.0)),
                  // Row para colocar o círculo ao lado do botão
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Círculo
                      Container(
                        width: 75, // Largura do círculo
                        height: 75, // Altura do círculo
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // Cor do círculo
                        ),
                      ),
                      SizedBox(width: 20), // Espaçamento entre o círculo e o botão
                      // Botão
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(280, 73),
                          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              bottomLeft: Radius.circular(0.0),
                              topRight: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                            ),
                          ),
                        ),
                        onPressed: () {}, // Ação do botão
                        child: const Text('Botão'), // Texto do botão
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