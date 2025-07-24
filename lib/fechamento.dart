import 'package:flutter/material.dart';
import 'package:flutter_application_2/fechamento_detalhes.dart';
import 'package:flutter_application_2/services/fechamento_service.dart';
import 'package:intl/intl.dart';

class Fechamento extends StatefulWidget {
  const Fechamento({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FechamentoState createState() => _FechamentoState();
}

class _FechamentoState extends State<Fechamento> {
  List<dynamic> fechamentos = []; // Lista para armazenar fechamentos
  bool isLoading = true; // Indica se os dados estão sendo carregados
  final FechamentoService _fechamentoService = FechamentoService(); // Novo service específico

  @override
  void initState() {
    super.initState();
    _loadFechamentos(); // Carrega os fechamentos ao inicializar
  }

  Future<void> _loadFechamentos() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedFechamentos = await _fechamentoService.getFechamentos();
      setState(() {
        fechamentos = fetchedFechamentos;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
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
          : fechamentos.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum fechamento encontrado',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: fechamentos.length,
                  itemBuilder: (context, index) {
                    final fechamento = fechamentos[index];
                    return _buildVendaItem(
                      MediaQuery.of(context).size.width,
                      fechamento,
                    );
                  },
                ),
    );
  }
}
