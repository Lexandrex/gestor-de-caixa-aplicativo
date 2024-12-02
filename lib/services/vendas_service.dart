import 'dart:convert';
import 'package:http/http.dart' as http;

class VendasService {
  final String baseUrl = 'http://10.0.2.2:3001';  // Para emulador Android

  // Função para obter vendas
  Future<List<dynamic>> getVendas() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/vendas'));

      if (response.statusCode == 200) {
        return json.decode(response.body);  // Retorna os dados da API
      } else {
        throw Exception('Erro ao carregar vendas');
      }
    } catch (e) {
      print('Erro: $e');
      return [];
    }
  }
}
