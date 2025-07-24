import 'package:flutter/material.dart';
import 'package:flutter_application_2/troca2.dart';
import 'package:flutter_application_2/services/troca_service.dart';
import 'package:intl/intl.dart';

class Troca extends StatefulWidget {
  const Troca({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TrocaState createState() => _TrocaState();
}

class _TrocaState extends State<Troca> {
  List<dynamic> trocas = []; // Lista para armazenar trocas
  bool isLoading = true; // Indica se os dados estão sendo carregados
  final TrocaService _trocaService = TrocaService(); // Novo service específico

  @override
  void initState() {
    super.initState();
    _loadTrocas(); // Carrega as trocas ao inicializar
  }

  Future<void> _loadTrocas() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedTrocas = await _trocaService.getTrocas();
      setState(() {
        trocas = fetchedTrocas;
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
  Widget _buildVendaItem(double screenWidth, dynamic troca) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
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
                builder: (context) => Troca2(
                  troca: troca,
                  trocaService: _trocaService,
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dia: ${formatarDia(troca['data'])}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              Text(
                'Total: R\$ ${troca['total'] ?? '0.00'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
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
          'TROCA',
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
          : trocas.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhuma troca encontradaaaaa',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: trocas.length,
                  itemBuilder: (context, index) {
                    final troca = trocas[index];
                    return _buildVendaItem(
                      MediaQuery.of(context).size.width,
                      troca,
                    );
                  },
                ),
    );
  }
}
