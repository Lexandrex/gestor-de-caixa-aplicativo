import 'base_service.dart';

class TrocaService extends BaseService {

  // Busca trocas com filtros opcionais
  Future<List<dynamic>> getTrocas({int? lojaId, String? mes, String? dia}) async {
    try {
      var query = supabase.from('trocas').select();
      
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
        throw Exception('Nenhuma troca encontradaaa');
      }
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar trocas: $e');
    }
  }

  // Registra uma nova troca
  Future<Map<String, dynamic>> createTroca(Map<String, dynamic> trocaData) async {
    try {
      final response = await supabase
          .from('trocas')
          .insert(trocaData)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Erro ao registrar troca: $e');
    }
  }

  // Atualiza uma troca
  Future<Map<String, dynamic>> updateTroca(int id, Map<String, dynamic> trocaData) async {
    try {
      final response = await supabase
          .from('trocas')
          .update(trocaData)
          .eq('id', id)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Erro ao atualizar troca: $e');
    }
  }

  // Deleta uma troca
  Future<void> deleteTroca(int id) async {
    try {
      await supabase.from('trocas').delete().eq('id', id);
    } catch (e) {
      throw Exception('Erro ao deletar troca: $e');
    }
  }

  // Verifica se uma venda tem troca disponível
  Future<bool> verificaTrocaDisponivel(int idVenda) async {
    try {
      final response = await supabase
          .from('trocas')
          .select('id')
          .eq('id_venda', idVenda);
      return response.isNotEmpty;
    } catch (e) {
      throw Exception('Erro ao verificar troca disponível: $e');
    }
  }
}
