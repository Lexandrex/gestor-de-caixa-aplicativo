import 'package:flutter/material.dart';
import 'package:flutter_application_1/gastos2.dart';
import 'package:flutter_application_1/services/gastos_service.dart';

class Gastos extends StatefulWidget {
  const Gastos({super.key});

  @override
  _GastosState createState() => _GastosState();
}

class _GastosState extends State<Gastos> {
  final List<Map<String, String>> _gastosList = [];
  final GastosService _gastosService = GastosService();
  double _totalGastos = 0.0; // Variável para armazenar o total dos gastos

  @override
  void initState() {
    super.initState();
    _fetchTotalGastos(); // Carrega o total dos gastos ao iniciar
  }

  // Função para buscar o total dos gastos
  void _fetchTotalGastos() async {
    try {
      final total = await _gastosService.getSomaGastos();
      setState(() {
        _totalGastos = total;
      });
    } catch (e) {
      // Caso haja algum erro na requisição
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao buscar total de gastos!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _addGasto(String valor, String descricao) async {
    try {
      final novoGasto = await _gastosService.createGasto({
        'quantidade': valor,
        'descricao': descricao,
      });

      setState(() {
        _gastosList.add({
          'qauntidade': novoGasto['quantidade'].toString(),
          'descricao': novoGasto['descricao'],
        });
      });

      _fetchTotalGastos(); // Atualiza o total dos gastos após adicionar um gasto
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao adicionar gasto!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAddGastoDialog() {
    double valor = 0.0;
    String descricao = '';

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
                    labelText: 'Valor',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                   keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    valor = double.tryParse(value) ?? 0.0;
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    descricao = value;
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
              child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                if (valor > 0 && descricao.isNotEmpty) {
                  _addGasto(valor.toString(), descricao);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar', style: TextStyle(color: Colors.white)),
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
        iconTheme: const IconThemeData(color: Colors.white),
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
              // Adiciona o botão com a soma dos gastos
              _buildTotalGastosButton(screenWidth),
// Exibe os gastos adicionados
for (var gasto in _gastosList)  // Iterando corretamente sobre a lista
  Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: _buildReportButton(screenWidth, gasto), // Passando o 'gasto' para o botão
  ),

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

  // Função para criar o botão que mostra a soma dos gastos
  Widget _buildTotalGastosButton(double screenWidth,) {
    return SizedBox(
      width: screenWidth * 0.85,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth * 0.85, 73),
          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
        ),
        onPressed: () {
          // Navega para a tela Gastos2
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Gastos2(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              '-${_totalGastos.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.red,
                fontSize: screenWidth * 0.07,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para o botão de relatório de gastos individuais (já existente)
  Widget _buildReportButton(double screenWidth, Map<String, String> gasto) {
    return SizedBox(
      width: screenWidth * 0.85,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth * 0.85, 73),
          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Gastos2(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              '-${_totalGastos.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.red,
                fontSize: screenWidth * 0.07,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
