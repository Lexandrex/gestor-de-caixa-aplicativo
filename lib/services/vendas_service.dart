import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Função para obter vendas (com filtros opcionais)
  Future<List<dynamic>> getVendas({String? formaPagamento, String? date}) async {
    try {
      // Inicia a query
      var query = supabase.from('vendas').select();

      // Aplica filtros, se existirem
      if (formaPagamento != null) {
        query = query.eq('formaPagamento', formaPagamento);
      }

      if (date != null) {
        query = query.eq('date', date);
      }

      // Executa a query e retorna os resultados
      final response = await query;
      return response as List<dynamic>;
    } catch (e) {
      throw Exception('Erro ao carregar vendas: $e');
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

      return response as Map<String, dynamic>;
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

    return response as Map<String, dynamic>;
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
