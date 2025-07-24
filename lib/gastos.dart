// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'gastos2.dart';
import 'services/gastos_service.dart';

// ignore: use_key_in_widget_constructors
class GastosScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _GastosScreenState createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  final GastoService _gastoService = GastoService();
  
  // Função para buscar os gastos usando o service
  Future<List<dynamic>> getGastos() async {
    try {
      return await _gastoService.getGastos();
    } catch (e) {
      print('Erro ao buscar gastos: $e');
      return [];
    }
  }

  // Função para exibir o diálogo de adicionar um novo gasto
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
        style: TextStyle(color: Colors.white), // Título em branco
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Valor',
              labelStyle: TextStyle(color: Colors.white), // Cor do rótulo
            ),
            style: const TextStyle(color: Colors.white), // Cor do texto no campo
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              valor = double.tryParse(value) ?? 0.0;
            },
          ),
          const SizedBox(height: 16), // Espaçamento entre os campos
          TextField(
            decoration: const InputDecoration(
              labelText: 'Descrição',
              labelStyle: TextStyle(color: Colors.white), // Cor do rótulo
            ),
            style: const TextStyle(color: Colors.white), // Cor do texto no campo
            onChanged: (value) {
              descricao = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white), // Cor do texto no botão
          ),
        ),
        TextButton(
          onPressed: () async {
            if (valor > 0 && descricao.isNotEmpty) {
              try {
                // Obtendo a data e hora atual do celular
                DateTime dataAtual = DateTime.now();
                
                // Formatando a data e hora
                String dataFormatada = DateFormat('yyyy-MM-dd HH:mm:ss').format(dataAtual);
                String horaFormatada = DateFormat('HH:mm:ss').format(dataAtual);

                // Usando o service para criar o gasto
                await _gastoService.criarGasto(
                  valor: valor,
                  descricao: descricao,
                  data: dataFormatada,
                  hora: horaFormatada
                );

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                setState(() {}); // Atualiza a tela
              } catch (e) {
                print('Erro ao adicionar gasto: $e');
              }
            }
          },
          child: const Text(
            'Adicionar',
            style: TextStyle(color: Colors.white), // Cor do texto no botão
          ),
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
      backgroundColor: const Color(0xFF393636), // Cor de fundo modificada
      appBar: AppBar(
        title: Text( 'GASTOS',
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.07,
        ),),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getGastos(), // Chama a função que retorna os dados dos gastos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Se houver dados
            List<dynamic> gastos = snapshot.data!;
            return ListView.builder(
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                var gasto = gastos[index];
                return _buildGastoItem(screenWidth, gasto); // Exibe o item do gasto
              },
            );
          } else {
            return const Center(child: Text('Nenhum gasto encontrado'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGastoDialog, // Chama o diálogo para adicionar um novo gasto
        backgroundColor: const Color(0xFF20805F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Método para exibir um item de gasto
  Widget _buildGastoItem(double screenWidth, dynamic gasto) {
    // Função para formatar a data, exibindo apenas o dia
    String formatarDia(String? data) {
      if (data == null) return 'Não informado';
      try {
        final parsedDate = DateTime.parse(data); // Converte a string para DateTime
        return DateFormat('dd').format(parsedDate); // Formata para exibir apenas o dia
      } catch (e) {
        return 'Inválido'; // Caso a conversão falhe
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espaçamento entre os itens
      child: SizedBox(
        width: screenWidth * 0.85,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth * 0.85, 73),
            backgroundColor: const Color.fromARGB(255, 83, 79, 79),
          ),
          onPressed: () {
            // Navega para a tela de detalhes com o gasto selecionado
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Gastos2(
          gasto: gasto,
          gastoService: _gastoService, // Passa o service para a tela de detalhes
        ),
      ),
    );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dia: ${formatarDia(gasto['data'])}', // Formata e exibe a data
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05, // Tamanho de fonte responsivo
                ),
              ),
              Text(
                'R\$ -${gasto['quantidade'] ?? '0.00'}', // Exibe o total gasto
                style: TextStyle(
                  color: Colors.red,
                  fontSize: screenWidth * 0.05, // Tamanho de fonte responsivo
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
