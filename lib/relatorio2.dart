import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vendas_service.dart'; // Importe o serviço

class RELATORIO2 extends StatefulWidget {
  const RELATORIO2({super.key});

  @override
  _RELATORIO2State createState() => _RELATORIO2State();
}

class _RELATORIO2State extends State<RELATORIO2> {
  List<dynamic> vendas = []; // Lista de vendas
  final ApiService apiService = ApiService(); // Instância do serviço
  bool isLoading = true; // Estado de carregamento
  String? selectedFormaPagamento; // Forma de pagamento selecionada
  String? selectedDate; // Data selecionada

  @override
  void initState() {
    super.initState();
    _loadVendas(); // Carrega as vendas ao inicializar o widget
  }

  Future<void> _loadVendas({String? formaPagamento, String? date}) async {
    setState(() {
      isLoading = true; // Exibe o indicador de carregamento
    });

    try {
      final fetchedVendas = await apiService.getVendas(
        formaPagamento: formaPagamento,
        date: date,
      );
      setState(() {
        vendas = fetchedVendas;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar vendas: $e')),
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
          'RELATÓRIO',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Filtro por Forma de Pagamento
              DropdownButton<String>(
                hint: const Text("Forma de Pagamento"),
                value: selectedFormaPagamento,
                items: <String>['dinheiro', 'cartao']
                    .map((forma) => DropdownMenuItem<String>(
                          value: forma,
                          child: Text(forma),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFormaPagamento = value;
                  });
                },
              ),
              const SizedBox(width: 10),
              // Filtro por Data
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
            ],
          ),
          ElevatedButton(
            onPressed: () => _loadVendas(
              formaPagamento: selectedFormaPagamento,
              date: selectedDate,
            ),
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
              : vendas.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma venda encontrada',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Expanded(child: _buildDataTable()), // Tabela de vendas
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
              _buildTableCell("HORA"),
              _buildTableCell("12"),
              _buildTableCell("20"),
              _buildTableCell("TOTAL"),
              _buildTableCell("FORMA DE PAGAMENTO"),
            ],
          ),
          // Preencher a tabela com os dados
          for (var venda in vendas)
            TableRow(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 83, 79, 79),
              ),
              children: [
                _buildTableCell(venda['data_hora'] ?? 'N/A'), // Hora
                _buildTableCell(
                    venda['quantidade_12']?.toString() ?? '0'), // 12
                _buildTableCell(
                    venda['quantidade_20']?.toString() ?? '0'), // 20
                _buildTableCell(
                    "R\$ ${(double.tryParse(venda['total'] ?? '0') ?? 0).toStringAsFixed(2)}"),
                _buildTableCell(
                    venda['formaPagamento'] ?? 'Não Informado'), // Pagamento
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
