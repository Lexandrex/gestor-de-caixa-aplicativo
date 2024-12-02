import 'dart:convert';
import 'package:http/http.dart' as http;

class FornecedorService {
  final String baseUrl = 'http://10.0.2.2:3001'; // Substitua pela URL do seu backend

  // Função para obter fornecedores
  Future<List<dynamic>> getFornecedores({String? nome, String? cnpj}) async {
    try {
      // Criação de um mapa para os parâmetros de consulta
      Map<String, String> queryParameters = {};

      if (nome != null) {
        queryParameters['nome'] = nome;
      }

      if (cnpj != null) {
        queryParameters['cnpj'] = cnpj;
      }

      // Construção da URL com os parâmetros de consulta
      final uri = Uri.parse('$baseUrl/fornecedor').replace(queryParameters: queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body); // Retorna a lista de fornecedores
      } else if (response.statusCode == 404) {
        return []; // Nenhum fornecedor encontrado
      } else {
        throw Exception('Erro ao carregar fornecedores: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  // Função para adicionar um fornecedor
  Future<void> createFornecedor(String nome, String cnpj, String telefone, String descricao) async {
    try {
      final uri = Uri.parse('$baseUrl/fornecedor');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nome': nome,
          'cnpj': cnpj,
          'telefone': telefone,  // Novo campo 'telefone' adicionado
          'descricao': descricao,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Erro ao criar fornecedor: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
