import 'package:supabase_flutter/supabase_flutter.dart';

class GastoService {
  final supabase = Supabase.instance.client;

  // Atualiza os dados de um gasto no Supabase
  Future<void> updateGasto(int id, double valor, String descricao) async {
    final response = await supabase
        .from('gastos') // Nome da tabela
        .update({
          'quantidade': valor,
          'descricao': descricao,
        })
        .eq('id', id); // Localiza pelo ID original

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  // Exclui um gasto no Supabase
  Future<void> deleteGasto(int id) async {
    final response = await supabase
        .from('gastos') // Nome da tabela
        .delete()
        .eq('id', id); // Localiza pelo ID

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
