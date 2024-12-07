import 'package:flutter/material.dart';
import 'package:flutter_application_1/fechamento_detalhes.dart'; // Tela de detalhes
import 'package:flutter_application_1/services/vendas_service.dart'; // Serviço para buscar vendas
import 'package:intl/intl.dart'; // Para formatar a data

class Fechamento extends StatefulWidget {
  const Fechamento({super.key});

  @override
  _FechamentoState createState() => _FechamentoState();
}

class _FechamentoState extends State<Fechamento> {
  List<dynamic> vendas = []; // Lista para armazenar vendas
  bool isLoading = true; // Indica se os dados estão sendo carregados
  final ApiService apiService = ApiService(); // Serviço da API

  @override
  void initState() {
    super.initState();
    _loadVendas(); // Carrega as vendas ao inicializar
  }

  Future<void> _loadVendas() async {
    setState(() {
      isLoading = true; // Mostra o indicador de carregamento
    });

    try {
      // Chamada à API para buscar vendas
      final fetchedVendas = await apiService.getVendas();
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

  // Função para formatar a data
  String formatarDia(String? data) {
    if (data == null) return 'Não informado';
    try {
      final parsedDate = DateTime.parse(data); // Converte a string em DateTime
      return DateFormat('dd').format(parsedDate); // Formata para exibir apenas o dia
    } catch (e) {
      return 'Inválido'; // Caso a conversão falhe
    }
  }

  // Método para criar os botões com o formato desejado
  Widget _buildVendaItem(double screenWidth, dynamic venda) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espaçamento entre os botões
      child: SizedBox(
        width: screenWidth * 0.85,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth * 0.85, 73),
            backgroundColor: const Color.fromARGB(255, 83, 79, 79),
          ),
          onPressed: () {
            // Navega para a tela FechamentoDetalhes passando a venda selecionada
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FechamentoDetalhes(venda: venda), // Passando a venda
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dia: ${formatarDia(venda['data'])}', // Formata a data para mostrar apenas o dia
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05, // Tamanho responsivo
                ),
              ),
              Text(
                'Total: R\$ ${venda['total'] ?? '0.00'}', // Mostra apenas o total
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05, // Tamanho responsivo
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          : vendas.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhuma venda encontrada',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: vendas.length,
                  itemBuilder: (context, index) {
                    final venda = vendas[index];
                    return _buildVendaItem(
                      MediaQuery.of(context).size.width, // Passando o screenWidth para o método
                      venda,
                    );
                  },
                ),
    );
  }
}
