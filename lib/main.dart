import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/fornecedor.dart';
import 'package:flutter_application_1/troca.dart';
import 'package:intl/intl.dart';
import 'relatorio2.dart'; // Importe a tela RELATORIO2

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializando o Supabase
  await Supabase.initialize(
    url: 'https://vvrjzlsaizsbttinnoyy.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ2cmp6bHNhaXpzYnR0aW5ub3l5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMyNjc0ODMsImV4cCI6MjA0ODg0MzQ4M30.ZYx6PMvp96VVaKptEMIIBHEHOsI23MzKbuqkl4awn3A', // Substitua pela sua chave pública do Supabase
  );

  runApp(const Atividade());
}

class Atividade extends StatelessWidget {
  const Atividade({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Atividade',
      home: Tela1(), // Define a Tela1 como a tela inicial
    );
  }
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  _Tela1State createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  bool _isExpanded = false; // Estado para controlar a expansão da AppBar

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded; // Alterna o estado de expansão
    });
  }

  // Função para buscar as vendas do Supabase
  Future<List<dynamic>> getVendas() async {
    try {
      final response = await Supabase.instance.client
          .from('vendas') // Nome da tabela no Supabase
          .select(); // Realiza a consulta

      // Se a resposta for vazia ou não for lista, retorna uma lista vazia
      if (response == null || response.isEmpty) {
        print('Nenhuma venda encontrada.');
        return [];
      }

      // Retorna os dados como lista
      return response as List<dynamic>;
    } catch (e) {
      // Em caso de erro, imprime e retorna uma lista vazia
      print('Erro ao buscar vendas: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF393636),
      appBar: AppBar(
        title: Text(
          'RELATÓRIO',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: screenWidth * 0.08, // Tamanho de fonte do AppBar
          ),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: _toggleExpansion, // Chama a função ao clicar no ícone
        ),
      ),
      body: Column(
        children: [
          if (_isExpanded) // Exibe as opções se estiver expandido
            Container(
              color: const Color(0xFF20805F),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton('GASTOS',  GastosScreen(), screenWidth),
                  _buildNavButton('FORNECEDOR', const FornecedorScreen(), screenWidth),
                  _buildNavButton('FECHAMENTO', const Fechamento(), screenWidth),
                  _buildNavButton('TROCA', const Troca(), screenWidth),
                ],
              ),
            ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: getVendas(), // Chama a função que retorna todas as vendas
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  // Se houver dados
                  List<dynamic> vendas = snapshot.data!;
                  return ListView.builder(
                    itemCount: vendas.length,
                    itemBuilder: (context, index) {
                      var venda = vendas[index];
                      return _buildVendaItem(
                        screenWidth,
                        venda, // Passando a venda completa
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Nenhuma venda encontrada'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para criar um botão de navegação
  Widget _buildNavButton(String label, Widget destination, double screenWidth) {
    return SizedBox(
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.035,
          ),
        ),
      ),
    );
  }

  // Método para exibir um item de venda com informações fixas
  Widget _buildVendaItem(double screenWidth, dynamic venda) {
    // Formata a data para exibir apenas o dia
    String formatarDia(String? data) {
      if (data == null) return 'Não informado';
      try {
        final parsedDate = DateTime.parse(data); // Converte a string em DateTime
        return DateFormat('dd').format(parsedDate); // Formata para exibir apenas o dia
      } catch (e) {
        return 'Inválido'; // Caso a conversão falhe
      }
    }

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
            // Navega para a tela RELATORIO2 passando a venda selecionada
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RELATORIO2(venda: venda), // Passando a venda
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
}
