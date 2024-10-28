import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/troca.dart';

// Definição de constantes para cores e estilos reutilizáveis
const Color corTexto = Color.fromARGB(255, 255, 255, 255);
const Color corFundo = Color(0xFF393636);
const Color corAppBar = Color(0xFF20805F);
const Color corIcone = Color.fromARGB(255, 83, 79, 79);

class Fornecedor2 extends StatefulWidget {
  const Fornecedor2({super.key});

  @override
  _Fornecedor2State createState() => _Fornecedor2State();
}

class _Fornecedor2State extends State<Fornecedor2> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo, // Cor de fundo ajustada
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'FORNECEDOR',
            style: TextStyle(
              color: corTexto,
              fontSize: 40,
            ),
          ),
        ),
        backgroundColor: corAppBar, // Cor da AppBar ajustada
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
              color: corAppBar,
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
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: corIcone, width: 4),
            ),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: corAppBar, width: 2),
                        shape: BoxShape.circle,
                        color: corIcone,
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: TextStyle(color: corTexto),
                            ),
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'CPF',
                                    labelStyle: TextStyle(color: corTexto),
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'CNPJ',
                                    labelStyle: TextStyle(color: corTexto),
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Telefone',
                                    labelStyle: TextStyle(color: corTexto),
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
