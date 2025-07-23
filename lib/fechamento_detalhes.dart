import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/gastos_service.dart';

class FechamentoDetalhes extends StatefulWidget {
  final Map<String, dynamic> venda;

  const FechamentoDetalhes({super.key, required this.venda});

  @override
  // ignore: library_private_types_in_public_api
  _FechamentoDetalhesState createState() => _FechamentoDetalhesState();
}

class _FechamentoDetalhesState extends State<FechamentoDetalhes> {
  final GastoService gastoService = GastoService();

  double totalVenda = 0;
  double totalGastos = 0;
  double lucro = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Obtém o total da venda
      totalVenda = double.tryParse(widget.venda['total']?.toString() ?? '0') ?? 0;

      // Pega a data da venda
      final vendaData = widget.venda['data']; // Campo "data" da venda

      // Busca os gastos no mesmo dia
      final response = await gastoService.supabase
          .from('gastos')
          .select('quantidade, data')
          .eq('data', vendaData); // Filtra pelos gastos do mesmo dia

      // Calcula o total de gastos
      totalGastos = (response as List<dynamic>)
          .fold(0, (sum, item) => sum + (double.tryParse(item['quantidade'].toString()) ?? 0));

      // Calcula o lucro
      lucro = totalVenda - totalGastos;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar detalhes: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: const Text(
          'FECHAMENTO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView( // Para garantir que o conteúdo não seja cortado
              child: Center( // Centraliza o conteúdo na tela
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: const Color(0xFF4F4B4B), // Cor do card
                    elevation: 8, // Sombra do card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // Bordas arredondadas
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Faz com que o card tenha o tamanho adequado ao conteúdo
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Data da Venda
                          Text(
                            "Data da Venda: ${widget.venda['data'] ?? 'N/A'}",
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 10),

                          // Hora da Venda
                          Text(
                            "Hora da Venda: ${widget.venda['hora'] ?? 'N/A'}",
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 20),

                          // Total da Venda
                          Text(
                            "Total da Venda: R\$ ${totalVenda.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Total de Gastos
                          Text(
                            "Total de Gastos: R\$ ${totalGastos.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Lucro
                          Text(
                            "Lucro: R\$ ${lucro.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: lucro >= 0 ? Colors.green : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
