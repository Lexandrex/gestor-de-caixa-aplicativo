import 'dart:convert';
import 'package:http/http.dart' as http;

class FornecedorService {
  final String baseUrl = 'http://10.0.2.2:3001'; // Substitua pela URL do seu backend

  // Função para obter fornecedores
  Future<List<dynamic>> getFornecedores({String? nome, String? cnpj}) async {
    try {
      Map<String, String> queryParameters = {};
      if (nome != null) queryParameters['nome'] = nome;
      if (cnpj != null) queryParameters['cnpj'] = cnpj;

      final uri = Uri.parse('$baseUrl/fornecedor').replace(queryParameters: queryParameters);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return [];
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
          'telefone': telefone,
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

  // Função para atualizar um fornecedor
  Future<void> updateFornecedor(String id, String nome, String cnpj, String telefone, String descricao) async {
    try {
      final uri = Uri.parse('$baseUrl/fornecedor/$id');
      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nome': nome,
          'cnpj': cnpj,
          'telefone': telefone,
          'descricao': descricao,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao atualizar fornecedor: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  // Função para deletar um fornecedor
  Future<void> deleteFornecedor(String id) async {
    try {
      final uri = Uri.parse('$baseUrl/fornecedor/$id');
      final response = await http.delete(uri);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Erro ao excluir fornecedor: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
  
}