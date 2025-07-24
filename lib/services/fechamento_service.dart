import 'base_service.dart';

class FechamentoService extends BaseService {

  // Busca fechamentos com filtros opcionais
  Future<List<dynamic>> getFechamentos({int? lojaId, String? mes, String? dia}) async {
    try {
      var query = supabase.from('fechamentos').select();
      
      if (lojaId != null) {
        query = query.eq('loja', lojaId);
      }
      if (mes != null) {
        query = query.ilike('data', '$mes%');
      }
      if (dia != null) {
        query = query.eq('data', dia);
      }

      final response = await query;
      if (response.isEmpty) {
        throw Exception('Nenhum fechamento encontrado.');
      }
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar fechamentos: $e');
    }
  }

  // Cria um novo fechamento
  Future<Map<String, dynamic>> createFechamento(Map<String, dynamic> fechamentoData) async {
    try {
      final response = await supabase
          .from('fechamentos')
          .insert(fechamentoData)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Erro ao criar fechamento: $e');
    }
  }

  // Atualiza um fechamento
  Future<Map<String, dynamic>> updateFechamento(int id, Map<String, dynamic> fechamentoData) async {
    try {
      final response = await supabase
          .from('fechamentos')
          .update(fechamentoData)
          .eq('id', id)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Erro ao atualizar fechamento: $e');
    }
  }

  // Deleta um fechamento
  Future<void> deleteFechamento(int id) async {
    try {
      await supabase.from('fechamentos').delete().eq('id', id);
    } catch (e) {
      throw Exception('Erro ao deletar fechamento: $e');
    }
  }
}
