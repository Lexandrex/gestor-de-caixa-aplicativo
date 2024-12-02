import 'dart:convert';
import 'package:http/http.dart' as http;

class GastosService {
  final String baseUrl = 'http://10.0.2.2:3001'; // Substitua pela URL do seu backend

  // Função para obter gastos (com filtro opcional por data)
  Future<List<dynamic>> getGastos({String? date}) async {
    try {
      // Criação de um mapa para os parâmetros de consulta
      Map<String, String> queryParameters = {};

      if (date != null) {
        queryParameters['date'] = date;
      }

      // Construção da URL com parâmetros de consulta
      final uri = Uri.parse('$baseUrl/gastos').replace(queryParameters: queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body); // Retorna a lista de gastos
      } else {
        throw Exception('Erro ao carregar gastos');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

 // Função para obter a soma dos gastos
  Future<double> getSomaGastos() async {
    try {
      // A URL não inclui mais os parâmetros de data
      final url = Uri.parse('$baseUrl/gastos/soma'); // URL para obter a soma dos gastos

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Retorna a soma dos gastos, caso exista
        return data['soma'] != null ? data['soma'].toDouble() : 0.0;
      } else {
        throw Exception('Erro ao carregar a soma dos gastos');
      }
    } catch (e) {
      // Caso ocorra algum erro
      throw Exception('Erro: $e');
    }
  }


  // Função para criar um novo gasto
 Future<Map<String, dynamic>> createGasto(Map<String, String> gastoData) async {
  final response = await http.post(
    Uri.parse('$baseUrl/gastos'), // Altere a URL conforme necessário
    headers: {"Content-Type": "application/json"},
    body: json.encode(gastoData), // Enviando os dados como JSON
  );

  print("Status code: ${response.statusCode}"); // Verifica o status da resposta
  print("Corpo da resposta: ${response.body}"); // Verifica o corpo da resposta

  if (response.statusCode == 201 || response.statusCode == 200) {
    return json.decode(response.body); // Retorna os dados recebidos do backend
  } else {
    // Caso o código de status não seja 201, você pode tentar lançar uma exceção com a mensagem de erro retornada
    throw Exception('Erro ao criar gasto123. Status: ${response.statusCode}');
  }
}


  // Função para atualizar um gasto existente
  Future<Map<String, dynamic>> updateGasto(int idGasto, Map<String, dynamic> gastoData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/gastos/$idGasto'),
        body: json.encode(gastoData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Retorna o gasto atualizado
      } else {
        throw Exception('Erro ao atualizar o gasto');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  // Função para deletar um gasto
  Future<Map<String, dynamic>> deleteGasto(int idGasto) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/gastos/$idGasto'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Retorna a resposta da deleção
      } else {
        throw Exception('Erro ao deletar o gasto');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
