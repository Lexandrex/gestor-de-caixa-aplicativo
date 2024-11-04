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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: Text(
          'RELATÓRIO',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: screenWidth * 0.08, // Tamanho de fonte do AppBar
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
                  _buildNavButton('GASTOS', const Gastos(), screenWidth),
                  _buildNavButton('FORNECEDOR', const Fornecedor(), screenWidth),
                  _buildNavButton('FECHAMENTO', const Fechamento(), screenWidth),
                  _buildNavButton('TROCA', const Troca(), screenWidth),
                ],
              ),
            ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Text(
                    "ANO",
                    style: TextStyle(
                      fontSize:
                          screenWidth * 0.05, // Tamanho de fonte responsivo
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "MÊS",
                        style: TextStyle(
                          fontSize:
                              screenWidth * 0.1, // Tamanho de fonte responsivo
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                  _buildReportButton(
                      screenWidth, 'Dia: 2', 'segunda-feira', 'R\$ 1500,00'),
                  const SizedBox(height: 8), // Separação entre os botões
                  _buildReportButton(
                      screenWidth, 'Dia: 3', 'terça-feira', 'R\$ 2000,00'),
                  const SizedBox(height: 8), // Separação entre os botões
                  _buildReportButton(
                      screenWidth, 'Dia: 4', 'quarta-feira', 'R\$ 2500,00'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para criar um botão de navegação
  Widget _buildNavButton(String label, Widget destination, double screenWidth) {
    return SizedBox(
      // Largura do botão
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize:
                screenWidth * 0.035, // Diminui o espaçamento entre as palavras
          ),
        ),
      ),
    );
  }

  // Método para criar um botão de relatório
  Widget _buildReportButton(
      double screenWidth, String dia, String diaDaSemana, String valor) {
    return SizedBox(
      width: screenWidth * 0.85, // Largura responsiva do botão
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth * 0.85, 73), // Tamanho responsivo
          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RELATORIO2(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  dia,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06, // Tamanho responsivo
                  ),
                ),
                Text(
                  diaDaSemana,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Text(
              valor,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.07, // Aumentando o tamanho responsivo
              ),
            ),
          ],
        ),
      ),
    );
  }
}
