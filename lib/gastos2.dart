import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/gastos_service.dart'; // Importe o serviço

class Gastos2 extends StatefulWidget {
  const Gastos2({super.key});

  @override
  _Gastos2State createState() => _Gastos2State();
}

class _Gastos2State extends State<Gastos2> {
  List<dynamic> gastos = []; // Lista de gastos
  final GastosService apiService = GastosService(); // Instância do serviço
  bool isLoading = true; // Estado de carregamento
  String? selectedDate; // Data selecionada

  @override
  void initState() {
    super.initState();
    _loadGastos(); // Carrega os gastos ao inicializar o widget
  }

  Future<void> _loadGastos({String? date}) async {
    setState(() {
      isLoading = true; // Exibe o indicador de carregamento
    });

    try {
      final fetchedGastos = await apiService.getGastos(date: date);
      setState(() {
        gastos = fetchedGastos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar gastos: $e')),
      );
    } finally {
      setState(() {
        isLoading = false; // Oculta o indicador de carregamento
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: const Text(
          'GASTOS',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            "DIA",
            style: TextStyle(fontSize: 40, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () async {
              final selected = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selected != null && selected != DateTime.now()) {
                setState(() {
                  selectedDate = "${selected.year}-${selected.month}-${selected.day}";
                });
              }
            },
            child: Text(selectedDate ?? 'Selecionar Data',
                style: const TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () => _loadGastos(date: selectedDate),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF20805F), width: 2),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              fixedSize: const Size(100, 50),
              backgroundColor: const Color.fromARGB(255, 83, 79, 79),
            ),
            child: const Text("FILTRAR", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 8),
          isLoading
              ? const Center(child: CircularProgressIndicator()) // Indicador de carregamento
              : gastos.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum gasto encontrado',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Expanded(child: _buildDataTable()), // Tabela de gastos
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        border: TableBorder.all(
          color: Colors.white,
          width: 1,
          borderRadius: BorderRadius.circular(4),
        ),
        children: [
          // Cabeçalho da Tabela
          TableRow(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 83, 79, 79),
            ),
            children: [
              _buildTableCell("VALOR"),
              _buildTableCell("DESCRIÇÃO"),
            ],
          ),
          // Preencher a tabela com os dados
          for (var gasto in gastos)
            TableRow(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 83, 79, 79),
              ),
              children: [
                _buildTableCell(gasto['valor'] ?? 'N/A'), // Valor
                _buildTableCell(gasto['descricao'] ?? 'N/A'), // Descrição
              ],
            ),
        ],
      ),
    );
  }

  static Widget _buildTableCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
