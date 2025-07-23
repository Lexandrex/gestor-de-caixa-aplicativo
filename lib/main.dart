// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_2/fechamento.dart';
import 'package:flutter_application_2/gastos.dart';
import 'package:flutter_application_2/fornecedor.dart';
import 'package:flutter_application_2/troca.dart';
import 'package:intl/intl.dart';
import 'relatorio2.dart'; // Importe a tela RELATORIO2

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializando o Supabase
  await Supabase.initialize(
    url: 'https://npvyxmorsaitlpscbcgq.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wdnl4bW9yc2FpdGxwc2NiY2dxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU0NTAyMDEsImV4cCI6MjA2MTAyNjIwMX0.VSLgSvLOYgEhul-QbXXIb4r91HD6_r76__QzElzOulM', // Substitua pela sua chave pública do Supabase
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
  // ignore: library_private_types_in_public_api
  _Tela1State createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  bool _isExpanded = false;
  int? _selectedLoja; // Loja selecionada
  String? _selectedMes; // Mês selecionado (yyyy-MM)
  String? _selectedDia; // Dia selecionado (yyyy-MM-dd)
  List<dynamic> _vendas = [];
  List<Map<String, dynamic>> _lojas = []; // Agora armazena id e nome
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchVendasELojas();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> _fetchVendasELojas() async {
    setState(() { _loading = true; });
    final vendas = await getVendas();
    final lojas = await getLojas();
    setState(() {
      _vendas = vendas;
      _lojas = lojas;
      _selectedLoja = lojas.isNotEmpty ? lojas.first['id'] as int : null;
      _selectedMes = null;
      _selectedDia = null;
      _loading = false;
    });
  }

  // Função para buscar as vendas do Supabase
  Future<List<dynamic>> getVendas() async {
    try {
      final response = await Supabase.instance.client
          .from('vendas') // Nome da tabela no Supabase
          .select(); // Realiza a consulta

      // Se a resposta for vazia ou não for lista, retorna uma lista vazia
      if (response.isEmpty) {
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

  // Busca as lojas do Supabase
  Future<List<Map<String, dynamic>>> getLojas() async {
    try {
      final response = await Supabase.instance.client
          .from('lojas')
          .select();
      if (response.isEmpty) return [];
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Erro ao buscar lojas: $e');
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: _buildLojaDropdown(screenWidth),
          ),
          if (_selectedLoja != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildMesDropdown(screenWidth),
            ),
          if (_selectedMes != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildDiaDropdown(screenWidth),
            ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _buildVendasList(screenWidth),
          ),
        ],
      ),
    );
  }

  Widget _buildLojaDropdown(double screenWidth) {
    // Se não há lojas, mostra mensagem
    if (_lojas.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text('Nenhuma loja cadastrada', style: TextStyle(color: Colors.white)),
      );
    }
    return GestureDetector(
      onTap: () {}, // Garante que o Container seja "clicável"
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF20805F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedLoja,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: const Color(0xFF20805F),
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
            hint: const Text('Selecione a loja', style: TextStyle(color: Colors.white)),
            items: _lojas.map((loja) => DropdownMenuItem(
              value: loja['id'] as int,
              child: Text(loja['nome'] ?? 'Loja ${loja['id']}', style: const TextStyle(color: Colors.white)),
            )).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLoja = value;
                _selectedMes = null;
                _selectedDia = null;
              });
            },
            // Habilita o Dropdown apenas se houver lojas
            disabledHint: const Text('Nenhuma loja disponível', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildMesDropdown(double screenWidth) {
    final meses = _vendas
        .where((v) => v['loja'] == _selectedLoja)
        .map<String>((v) => v['data']?.substring(0, 7) ?? '')
        .toSet()
        .where((m) => m.isNotEmpty)
        .toList()
      ..sort();
    return DropdownButton<String>(
      value: _selectedMes,
      hint: const Text('Selecione o mês', style: TextStyle(color: Colors.white)),
      dropdownColor: const Color(0xFF20805F),
      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
      items: meses.map((mes) => DropdownMenuItem(
        value: mes,
        child: Text(DateFormat('MM/yyyy').format(DateTime.parse('$mes-01'))),
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedMes = value;
          _selectedDia = null;
        });
      },
    );
  }

  Widget _buildDiaDropdown(double screenWidth) {
    final dias = _vendas
        .where((v) => v['loja'] == _selectedLoja && v['data']?.startsWith(_selectedMes ?? ''))
        .map<String>((v) => v['data'] ?? '')
        .toSet()
        .where((d) => d.isNotEmpty)
        .toList()
      ..sort();
    return DropdownButton<String>(
      value: _selectedDia,
      hint: const Text('Selecione o dia', style: TextStyle(color: Colors.white)),
      dropdownColor: const Color(0xFF20805F),
      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
      items: dias.map((dia) => DropdownMenuItem(
        value: dia,
        child: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(dia))),
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDia = value;
        });
      },
    );
  }

  Widget _buildVendasList(double screenWidth) {
    List<dynamic> vendasFiltradas = _vendas;
    if (_selectedLoja != null) {
      vendasFiltradas = vendasFiltradas.where((v) => v['loja'] == _selectedLoja).toList();
    }
    if (_selectedMes != null) {
      vendasFiltradas = vendasFiltradas.where((v) => v['data']?.startsWith(_selectedMes ?? '')).toList();
    }
    if (_selectedDia == null && _selectedMes != null) {
      // Mostra lista de dias do mês
      final dias = vendasFiltradas.map<String>((v) => v['data'] ?? '').toSet().toList()..sort();
      if (dias.isEmpty) {
        return const Center(child: Text('Nenhum dia encontrado', style: TextStyle(color: Colors.white)));
      }
      return ListView.builder(
        itemCount: dias.length,
        itemBuilder: (context, index) {
          final dia = dias[index];
          final vendasDoDia = vendasFiltradas.where((v) => v['data'] == dia).toList();
          return ListTile(
            title: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(dia)), style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05)),
            subtitle: Text('Vendas: ${vendasDoDia.length}', style: const TextStyle(color: Colors.white70)),
            tileColor: const Color(0xFF53504F),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RELATORIO2(vendas: vendasDoDia, dia: dia),
                ),
              );
            },
          );
        },
      );
    }
    if (_selectedMes == null && _selectedLoja != null) {
      // Mostra lista de meses
      final meses = vendasFiltradas.map<String>((v) => v['data']?.substring(0, 7) ?? '').toSet().toList()..sort();
      if (meses.isEmpty) {
        return const Center(child: Text('Nenhum mês encontrado', style: TextStyle(color: Colors.white)));
      }
      return ListView.builder(
        itemCount: meses.length,
        itemBuilder: (context, index) {
          final mes = meses[index];
          final vendasDoMes = vendasFiltradas.where((v) => v['data']?.startsWith(mes)).toList();
          return ListTile(
            title: Text(DateFormat('MM/yyyy').format(DateTime.parse('$mes-01')), style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05)),
            subtitle: Text('Vendas: ${vendasDoMes.length}', style: const TextStyle(color: Colors.white70)),
            tileColor: const Color(0xFF53504F),
            onTap: () {
              setState(() {
                _selectedMes = mes;
                _selectedDia = null;
              });
            },
          );
        },
      );
    }
    // Se nada selecionado, mostra instrução
    return const Center(child: Text('Selecione uma loja para ver os relatórios', style: TextStyle(color: Colors.white)));
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
            // Navega para a tela RELATORIO2 passando apenas a venda selecionada como lista
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RELATORIO2(vendas: [venda], dia: venda['data'] ?? ''),
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
