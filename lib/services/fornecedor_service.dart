import 'package:supabase_flutter/supabase_flutter.dart';

class FornecedorService {
  final supabase = Supabase.instance.client;

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
