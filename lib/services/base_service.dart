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
        query = query.ilike(campoData, '$mes%');
      }
      if (dia != null) {
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
}
