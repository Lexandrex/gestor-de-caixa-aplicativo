import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:3001'; // Substitua pela URL do seu backend

  // Função para obter vendas
  Future<List<dynamic>> getVendas({String? formaPagamento, String? date}) async {
    try {
      // Criação de um mapa para os parâmetros de consulta
      Map<String, String> queryParameters = {};

      if (formaPagamento != null) {
        queryParameters['formaPagamento'] = formaPagamento;
      }

      if (date != null) {
        queryParameters['date'] = date;
      }

      // Construção da URL com parâmetros de consulta
      final uri = Uri.parse('$baseUrl/vendas').replace(queryParameters: queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body); // Retorna a lista de vendas
      } else {
        throw Exception('Erro ao carregar vendas');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  // Função para atualizar uma venda
  Future<Map<String, dynamic>> updateVendas(int idVenda, Map<String, dynamic> vendaData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/vendas/$idVenda'),
        body: json.encode(vendaData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Retorna a venda atualizada
      } else {
        throw Exception('Erro ao atualizar a venda');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  // Função para deletar uma venda
  Future<Map<String, dynamic>> deleteVendas(int idVenda) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/vendas/$idVenda'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Retorna a resposta da deleção
      } else {
        throw Exception('Erro ao deletar a venda');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
