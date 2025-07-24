import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Métodos comuns que podem ser usados por todos os services
  Future<List<Map<String, dynamic>>> getLojas() async {
    try {
      final response = await supabase.from('lojas').select();
      if (response.isEmpty) {
        throw Exception('Nenhuma loja encontrada');
      }
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Erro ao buscar lojas: $e');
    }
  }

  // Função genérica para buscar registros com filtros de data
  // Função para converter data YYYY-MM-DD para AA/MM/DD
  String _formatDataParaBanco(String data) {
    if (data.isEmpty) return data;
    // Remove hífens e pega apenas os últimos 2 dígitos do ano
    final partes = data.split('-');
    if (partes.length == 3) {
      final ano = partes[0].substring(2); // Pega últimos 2 dígitos
      return '$ano/${partes[1]}/${partes[2]}';
    }
    return data;
  }

  Future<List<dynamic>> getRegistros(String tabela, {
    int? lojaId,
    String? mes,
    String? dia,
    String campoData = 'data',
    String campoLoja = 'loja'
  }) async {
    try {
      var query = supabase.from(tabela).select();
      
      if (lojaId != null) {
        query = query.eq(campoLoja, lojaId);
      }
      if (mes != null) {
        final ano = int.parse(mes.substring(0, 4));
        final mesNum = int.parse(mes.substring(5, 7));
        final ultimoDia = DateTime(ano, mesNum + 1, 0).day;
        
        // Formata as datas mantendo YYYY-MM-DD
        final dataInicio = '${mes}-01';
        final dataFim = '$mes-$ultimoDia';
        
        // Filtra registros entre o início e fim do mês
        query = query.gte(campoData, dataInicio)
                    .lte(campoData, dataFim);
      }
      if (dia != null) {
        // Usa a data YYYY-MM-DD diretamente
        query = query.eq(campoData, dia);
      }

      final response = await query;
      if (response.isEmpty) {
        throw Exception('Nenhum registro encontrado em $tabela');
      }
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar registros de $tabela: $e');
    }
  }

  // Função para buscar meses disponíveis
  Future<List<String>> getMesesDisponiveis(String tabela, {
    int? lojaId,
    String campoData = 'data',
    String campoLoja = 'loja'
  }) async {
    try {
      var query = supabase
          .from(tabela)
          .select(campoData);
      
      if (lojaId != null) {
        query = query.eq(campoLoja, lojaId);
      }

      final response = await query;
      if (response.isEmpty) {
        throw Exception('Nenhum registro encontrado em $tabela');
      }

      // Extrai os meses únicos (YYYY-MM) dos registros
      final meses = response
          .map<String>((r) => r[campoData]?.toString().substring(0, 7) ?? '')
          .where((m) => m.isNotEmpty)
          .toSet()
          .toList();

      meses.sort(); // Ordena os meses
      return meses;
    } catch (e) {
      throw Exception('Erro ao buscar meses disponíveis: $e');
    }
  }

  // Função para buscar dias disponíveis em um mês
  Future<List<String>> getDiasDisponiveis(String tabela, String mes, {
    int? lojaId,
    String campoData = 'data',
    String campoLoja = 'loja'
  }) async {
    try {
      final ano = int.parse(mes.substring(0, 4));
      final mesNum = int.parse(mes.substring(5, 7));
      final ultimoDia = DateTime(ano, mesNum + 1, 0).day;

      // Formata as datas mantendo YYYY-MM-DD
      final dataInicio = '${mes}-01';
      final dataFim = '$mes-$ultimoDia';

      var query = supabase
          .from(tabela)
          .select(campoData)
          .gte(campoData, dataInicio)
          .lte(campoData, dataFim);
      
      if (lojaId != null) {
        query = query.eq(campoLoja, lojaId);
      }

      final response = await query;
      if (response.isEmpty) {
        throw Exception('Nenhum registro encontrado para o mês $mes');
      }

      // Extrai os dias únicos do mês
      final dias = response
          .map<String>((r) => r[campoData]?.toString() ?? '')
          .where((d) => d.isNotEmpty)
          .toSet()
          .toList();

      dias.sort(); // Ordena os dias
      return dias;
    } catch (e) {
      throw Exception('Erro ao buscar dias disponíveis: $e');
    }
  }
}
