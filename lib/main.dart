import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_2/fechamento.dart';
import 'package:flutter_application_2/gastos.dart';
import 'package:flutter_application_2/fornecedor.dart';
import 'package:flutter_application_2/troca.dart';
import 'package:intl/intl.dart';
import 'relatorio2.dart';
import 'services/vendas_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://npvyxmorsaitlpscbcgq.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wdnl4bW9yc2FpdGxwc2NiY2dxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU0NTAyMDEsImV4cCI6MjA2MTAyNjIwMX0.VSLgSvLOYgEhul-QbXXIb4r91HD6_r76__QzElzOulM',
  );

  runApp(const Atividade());
}

class Atividade extends StatelessWidget {
  const Atividade({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Atividade',
      home: Tela1(),
    );
  }
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  final VendasService _vendasService = VendasService();
  bool _isExpanded = false;
  bool _loading = false;
  List<Map<String, dynamic>> _lojas = [];
  int? _selectedLoja;
  String? _selectedMes;
  String? _selectedDia;

  @override
  void initState() {
    super.initState();
    _fetchLojas();
  }

  Future<void> _fetchLojas() async {
    setState(() {
      _loading = true;
    });

    try {
      final lojas = await _vendasService.getLojas();
      setState(() {
        _lojas = lojas;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar lojas: $e')),
        );
      }
    }
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _buildLojaDropdown(double screenWidth) {
    if (_lojas.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text('Nenhuma loja cadastrada', style: TextStyle(color: Colors.white)),
      );
    }

    return Container(
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
        ),
      ),
    );
  }

  Widget _buildMesDropdown(double screenWidth) {
    return FutureBuilder<List<String>>(
      future: _vendasService.getMesesComVendas(lojaId: _selectedLoja),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}',
            style: const TextStyle(color: Colors.white)
          );
        }

        final meses = snapshot.data ?? [];
        if (meses.isEmpty) {
          return const Text(
            'Nenhum mês encontrado',
            style: TextStyle(color: Colors.white)
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF20805F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedMes,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: const Color(0xFF20805F),
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.045
              ),
              hint: const Text(
                'Selecione o mês',
                style: TextStyle(color: Colors.white)
              ),
              items: meses.map((mes) => DropdownMenuItem(
                value: mes,
                child: Text(
                  DateFormat('MM/yyyy').format(DateTime.parse('$mes-01')),
                  style: const TextStyle(color: Colors.white)
                ),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMes = value;
                  _selectedDia = null;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiaDropdown(double screenWidth) {
    if (_selectedMes == null) return Container();

    return FutureBuilder<List<String>>(
      future: _vendasService.getDiasComVendas(_selectedMes!, lojaId: _selectedLoja),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}',
            style: const TextStyle(color: Colors.white)
          );
        }

        final dias = snapshot.data ?? [];
        if (dias.isEmpty) {
          return const Text(
            'Nenhum dia encontrado',
            style: TextStyle(color: Colors.white)
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF20805F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedDia,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: const Color(0xFF20805F),
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.045
              ),
              hint: const Text(
                'Selecione o dia',
                style: TextStyle(color: Colors.white)
              ),
              items: dias.map((dia) => DropdownMenuItem(
                value: dia,
                child: Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(dia)),
                  style: const TextStyle(color: Colors.white)
                ),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDia = value;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildVendasList(double screenWidth) {
    if (_selectedLoja == null) {
      return const Center(
        child: Text(
          'Selecione uma loja para ver os relatórios',
          style: TextStyle(color: Colors.white)
        ),
      );
    }

    return FutureBuilder<List<dynamic>>(
      future: _vendasService.getVendas(
        lojaId: _selectedLoja,
        mes: _selectedMes,
        dia: _selectedDia
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro: ${snapshot.error}',
              style: const TextStyle(color: Colors.white)
            ),
          );
        }

        final vendas = snapshot.data ?? [];
        if (vendas.isEmpty) {
          return const Center(
            child: Text(
              'Nenhuma venda encontrada',
              style: TextStyle(color: Colors.white)
            ),
          );
        }

        if (_selectedDia != null) {
          // Mostra vendas do dia
          return ListView.builder(
            itemCount: vendas.length,
            itemBuilder: (context, index) {
              final venda = vendas[index];
              return ListTile(
                title: Text(
                  'Venda #${venda['id']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05
                  ),
                ),
                subtitle: Text(
                  'Total: R\$ ${venda['total']}',
                  style: const TextStyle(color: Colors.white70)
                ),
                tileColor: const Color(0xFF53504F),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RELATORIO2(
                        vendas: [venda],
                        dia: venda['data']
                      ),
                    ),
                  );
                },
              );
            },
          );
        }

        // Agrupa vendas por dia
        final vendasPorDia = <String, List<dynamic>>{};
        for (var venda in vendas) {
          final data = venda['data'] as String;
          if (!vendasPorDia.containsKey(data)) {
            vendasPorDia[data] = [];
          }
          vendasPorDia[data]!.add(venda);
        }

        final dias = vendasPorDia.keys.toList()..sort();
        return ListView.builder(
          itemCount: dias.length,
          itemBuilder: (context, index) {
            final dia = dias[index];
            final vendasDoDia = vendasPorDia[dia]!;
            final total = vendasDoDia.fold<double>(
              0,
              (sum, venda) => sum + (double.tryParse(venda['total'].toString()) ?? 0)
            );

            return ListTile(
              title: Text(
                DateFormat('dd/MM/yyyy').format(DateTime.parse(dia)),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05
                ),
              ),
              subtitle: Text(
                'Vendas: ${vendasDoDia.length} - Total: R\$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white70)
              ),
              tileColor: const Color(0xFF53504F),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RELATORIO2(
                      vendas: vendasDoDia,
                      dia: dia
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildNavButton(String label, Widget destination, double screenWidth) {
    return TextButton(
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
    );
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
            color: Colors.white,
            fontSize: screenWidth * 0.08,
          ),
        ),
        backgroundColor: const Color(0xFF20805F),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: _toggleExpansion,
        ),
      ),
      body: Column(
        children: [
          if (_isExpanded)
            Container(
              color: const Color(0xFF20805F),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton('GASTOS', GastosScreen(), screenWidth),
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
}
