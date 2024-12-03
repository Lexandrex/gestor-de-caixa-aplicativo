import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vendas_service.dart'; 
import 'package:flutter_application_1/fechamento.dart';
import 'package:flutter_application_1/gastos.dart';
import 'package:flutter_application_1/fornecedor.dart';
import 'package:flutter_application_1/troca.dart';

void main() => runApp(const Atividade());

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

  // Função para obter todas as vendas do banco de dados
  Future<List<dynamic>> getVendas() async {
    ApiService apiService = ApiService();
    try {
      return await apiService.getVendas(); // Chama o serviço de API para buscar todas as vendas
    } catch (e) {
      // Em caso de erro, você pode retornar uma lista vazia ou tratar de outra maneira
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
                  _buildNavButton('GASTOS', const Gastos(), screenWidth),
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
    return SizedBox(
      width: screenWidth * 0.85,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth * 0.85, 73), 
          backgroundColor: const Color.fromARGB(255, 83, 79, 79),
        ),
        onPressed: () {
          // Lógica do botão ao ser pressionado
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hora: ${venda['hora'] ?? 'Não Informado'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06, // Tamanho responsivo
                  ),
                ),
                Text(
                  'Forma de Pagamento: ${venda['formaPagamento'] ?? 'Não Informado'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Qtd 12: ${venda['quantidade_12'] ?? 0}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Qtd 20: ${venda['quantidade_20'] ?? 0}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Total: R\$ ${venda['total'] ?? '0.00'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}