import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_2/fechamento.dart';
import 'package:flutter_application_2/gastos.dart';
import 'package:flutter_application_2/fornecedor.dart';
import 'package:flutter_application_2/troca.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
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
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
              _selectedDay = null;
            });
          },
        ),
      ),
    );
  }

  Future<void> _showCalendarDialog(BuildContext context) async {
    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime? tempSelectedDay = _selectedDay;
        DateTime tempFocusedDay = _focusedDay;
        
        return Dialog(
          backgroundColor: const Color(0xFF393636),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: tempFocusedDay,
                  selectedDayPredicate: (day) {
                    return tempSelectedDay != null && 
                      isSameDay(tempSelectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    tempSelectedDay = selectedDay;
                    tempFocusedDay = focusedDay;
                    Navigator.of(context).pop(selectedDay);
                  },
                  calendarFormat: CalendarFormat.month,
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.white70),
                    selectedDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Color(0xFF20805F)),
                    todayDecoration: BoxDecoration(
                      color: Colors.white38,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(color: Colors.white),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white),
                    weekendStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                  ),
                  if (tempSelectedDay != null)
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(tempSelectedDay),
                      child: const Text('OK', style: TextStyle(color: Colors.white)),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDay = selectedDate;
        _focusedDay = selectedDate;
      });
    }
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
        data: _selectedDay
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
          return Center(
            child: Text(
              _selectedDay != null 
                ? 'Nenhuma venda encontrada para ${DateFormat('dd/MM/yyyy').format(_selectedDay!)}'
                : 'Nenhuma venda encontrada',
              style: const TextStyle(color: Colors.white)
            ),
          );
        }

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
              child: InkWell(
                onTap: () => _showCalendarDialog(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF20805F),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDay != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDay!)
                            : 'Selecione uma data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.white),
                    ],
                  ),
                ),
              ),
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
