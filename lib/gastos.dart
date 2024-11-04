import 'package:flutter/material.dart';
import 'package:flutter_application_1/gastos2.dart';

class Gastos extends StatefulWidget {
  const Gastos({super.key});

  @override
  _GastosState createState() => _GastosState();
}

class _GastosState extends State<Gastos> {
  final List<Map<String, String>> _gastosList = [];

  void _addGasto(String dia, String diaDaSemana, String valor) {
    setState(() {
      _gastosList.add({'dia': dia, 'diaDaSemana': diaDaSemana, 'valor': valor});
    });
  }

  void _showAddGastoDialog() {
    String dia = '';
    String diaDaSemana = '';
    String valor = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF393636),
          title: const Text(
            'Adicionar Gasto',
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Dia',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    dia = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Dia da Semana',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    diaDaSemana = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    valor = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                if (dia.isNotEmpty &&
                    diaDaSemana.isNotEmpty &&
                    valor.isNotEmpty) {
                  _addGasto(dia, diaDaSemana, valor);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'GASTOS',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.1,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.white), // Muda a cor da seta para branco
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(
                "ANO",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "MÊS",
                    style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Exibe os gastos na lista
              for (var gasto in _gastosList)
                _buildReportButton(screenWidth, gasto['dia']!,
                    gasto['diaDaSemana']!, gasto['valor']!),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGastoDialog,
        backgroundColor: const Color(0xFF20805F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Método para criar um botão de relatório
  Widget _buildReportButton(
      double screenWidth, String dia, String diaDaSemana, String valor) {
    return SizedBox(
      width: screenWidth * 0.85,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth * 0.85, 73),
          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Gastos2(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dia,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
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
                fontSize: screenWidth * 0.07,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
