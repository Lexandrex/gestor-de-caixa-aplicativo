import 'base_service.dart';

class VendasService extends BaseService {

  // Função para obter vendas por data
  Future<List<dynamic>> getVendas({int? lojaId, DateTime? data}) async {
    try {
      var query = supabase.from('vendas').select();
      
      if (lojaId != null) {
        query = query.eq('loja', lojaId);
      }
      
      if (data != null) {
        // Formata a data para YYYY-MM-DD
        String dataFormatada = "${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}";
        query = query.eq('data', dataFormatada);
      }

      final response = await query;
      if (response.isEmpty) {
        return [];
      }
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar vendas: $e');
    }
  }

  // Busca todas as lojas
  @override
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

  // Função para atualizar uma venda
  Future<Map<String, dynamic>> updateVendas(int idVenda, Map<String, dynamic> vendaData) async {
    try {
      final response = await supabase
          .from('vendas')
          .update(vendaData)
          .eq('id_venda', idVenda)
          .select()
          .single();

      return response;
    } catch (e) {
      throw Exception('Erro ao atualizar a venda: $e');
    }
  }

  // Função para atualizar os campos específicos de uma venda
  Future<Map<String, dynamic>> updateVendaCampos(int idVenda, {int? quantidade12, int? quantidade20, String? formaPagamento}) async {
  try {
    // Prepara o mapa de dados que precisa ser atualizado
    final Map<String, dynamic> vendaData = {};

    // Verifica se o campo é nulo e define um valor default (por exemplo, 0)
    if (quantidade12 != null) {
      vendaData['quantidade_12'] = quantidade12;
    } else {
      vendaData['quantidade_12'] = 0; // Valor default caso seja nulo
    }

    if (quantidade20 != null) {
      vendaData['quantidade_20'] = quantidade20;
    } else {
      vendaData['quantidade_20'] = 0; // Valor default caso seja nulo
    }

    if (formaPagamento != null) {
      vendaData['formaPagamento'] = formaPagamento;
    }

    // Atualiza a venda no banco de dados
    final response = await supabase
        .from('vendas')
        .update(vendaData)
        .eq('id_venda', idVenda)
        .select()
        .single();

    return response;
  } catch (e) {
    throw Exception('Erro ao atualizar os campos da venda: $e');
  }
}


  // Função para deletar uma venda
  Future<void> deleteVendas(int idVenda) async {
    try {
      await supabase.from('vendas').delete().eq('id_venda', idVenda);
    } catch (e) {
      throw Exception('Erro ao deletar a venda: $e');
    }
  }
}
