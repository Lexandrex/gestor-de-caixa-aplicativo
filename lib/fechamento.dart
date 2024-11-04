import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class Fechamento extends StatelessWidget {
  const Fechamento({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém as dimensões da tela
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF393636), // Cor de fundo
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0), // Adiciona padding ao título
          child: Text(
            'FECHAMENTO',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: screenWidth * 0.1, // Tamanho de fonte responsivo
            ),
          ),
        ),
        backgroundColor: const Color(0xFF20805F), // Cor de fundo
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Volta para a tela anterior
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(
                    width: screenWidth * 0.85, // Largura responsiva do botão
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(screenWidth * 0.85, 73), // Tamanho responsivo
                        backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Tela1()),
                      ),
                      child: const Text('Ir para Tela 1'), // Texto do botão
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
