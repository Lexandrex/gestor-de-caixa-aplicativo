import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://seu-backend-url'; // Substitua pela URL do seu backend

  // Função para obter vendas
  Future<List<dynamic>> getVendas({String? formaPagamento, String? date}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/vendas?formaPagamento=$formaPagamento&date=$date'),
      );
      
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
