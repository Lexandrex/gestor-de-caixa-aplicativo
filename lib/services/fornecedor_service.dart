import 'base_service.dart';

class FornecedorService extends BaseService {

  // Adiciona um novo fornecedor
  Future<void> addFornecedor(fornecedor) async {
    final response = await supabase
        .from('fornecedor')
        .insert(fornecedor.toJson());

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  // Busca todos os fornecedores
  Future<List<dynamic>> getFornecedores() async {
    try {
      final response = await supabase.from('fornecedor').select();
      if (response.isEmpty) {
        throw Exception('Nenhum fornecedor encontrado');
      }
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar fornecedores: $e');
    }
  }

  // Atualiza os dados de um fornecedor no Supabase
  Future<void> updateFornecedor(String cnpj, String nome, String novoCnpj, String telefone, String descricao) async {
    final response = await supabase
        .from('fornecedor') // Nome da tabela
        .update({
          'nome': nome,
          'cnpj': novoCnpj,
          'telefone': telefone,
          'descricao': descricao,
        })
        .eq('cnpj', cnpj); // Localiza pelo CNPJ original

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  // Exclui um fornecedor no Supabase
  Future<void> deleteFornecedor(String cnpj) async {
    final response = await supabase
        .from('fornecedor') // Nome da tabela
        .delete()
        .eq('cnpj', cnpj); // Localiza pelo CNPJ

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
