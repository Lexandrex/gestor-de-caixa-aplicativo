import 'base_service.dart';

class GastoService extends BaseService {
  // Busca todos os gastos
  Future<List<dynamic>> getGastos() async {
    try {
      final response = await supabase.from('gastos').select();
      if (response.isEmpty) {
        throw Exception('Nenhum gasto encontrado');
      }
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar gastos: $e');
    }
  }

  // Busca gastos por data
  Future<List<dynamic>> getGastosPorData(String data) async {
    try {
      final response = await supabase
          .from('gastos')
          .select()
          .eq('data', data);
      if (response.isEmpty) {
        throw Exception('Nenhum gasto encontrado para a data: $data');
      }
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar gastos por data: $e');
    }
  }

  // Cria um novo gasto
  Future<void> criarGasto({
    required double valor,
    required String descricao,
    required String data,
    required String hora,
  }) async {
    try {
      final response = await supabase
          .from('gastos')
          .insert([
            {
              'quantidade': valor,
              'descricao': descricao,
              'data': data,
              'hora': hora,
            }
          ]);

      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      throw Exception('Erro ao criar gasto: $e');
    }
  }

  // Atualiza os dados de um gasto
  Future<void> updateGasto(int id, {
    double? valor,
    String? descricao,
    String? data,
    String? hora,
  }) async {
    try {
      final Map<String, dynamic> updateData = {};
      
      if (valor != null) updateData['quantidade'] = valor;
      if (descricao != null) updateData['descricao'] = descricao;
      if (data != null) updateData['data'] = data;
      if (hora != null) updateData['hora'] = hora;

      final response = await supabase
          .from('gastos')
          .update(updateData)
          .eq('id', id);

      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      throw Exception('Erro ao atualizar gasto: $e');
    }
  }

  // Exclui um gasto
  Future<void> deleteGasto(int id) async {
    try {
      final response = await supabase
          .from('gastos')
          .delete()
          .eq('id', id);

      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      throw Exception('Erro ao deletar gasto: $e');
    }
  }

  // Calcula total de gastos por período
  Future<double> calcularTotalGastos({String? data}) async {
    try {
      var query = supabase.from('gastos').select('quantidade');
      
      if (data != null) {
        query = query.eq('data', data);
      }

      final response = await query;
      double total = 0.0;
      
      for (var gasto in response) {
        if (gasto['quantidade'] != null) {
          total += (gasto['quantidade'] as num).toDouble();
        }
      }
      
      return total;
    } catch (e) {
      throw Exception('Erro ao calcular total de gastos: $e');
    }
  }
}
