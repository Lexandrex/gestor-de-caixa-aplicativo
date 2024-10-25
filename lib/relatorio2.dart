import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';


class RELATORIO2 extends StatefulWidget {
  const RELATORIO2({super.key});

  @override
  _RELATORIO2State createState() => _RELATORIO2State();
}

class _RELATORIO2State extends State<RELATORIO2> {
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
            'RELATÓRIO', // Título igual ao da Tela1
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 40,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF20805F), // Cor de fundo igual à Tela1
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu,
          color: Colors.white),
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
                    onPressed: () {}, // Ação da Opção 2
                    child: const Text('Opção 2', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {}, // Ação da Opção 3
                    child: const Text('Opção 3', style: TextStyle(color: Colors.white)),
                  ),
                    TextButton(
                    onPressed: () {}, // Ação da Opção 3
                    child: const Text('Opção 3', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Padding(padding: EdgeInsets.all(8.0)),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "DIA",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ]),
                 Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Text("Coluna 1"),
        Text("Coluna 2"),
        Text("Coluna 3"),
      ],
    ),
    TableRow(
      children: [
        Text("Linha 1"),
        Text("Linha 1"),
        Text("Linha 1"),
      ],
    ),
    TableRow(
      children: [
        Text("Linha 2"),
        Text("Linha 2"),
        Text("Linha 2"),
      ],
    ),
  ],
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