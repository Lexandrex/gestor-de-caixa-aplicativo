import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'fornecedor2.dart';

class Fornecedor {
  final String nome;
  final String cnpj;
  final String telefone;
  final String descricao;

  Fornecedor({
    required this.nome,
    required this.cnpj,
    required this.telefone,
    required this.descricao,
  });

  // Converte um Map (do Supabase) para um objeto Fornecedor
  factory Fornecedor.fromMap(Map<String, dynamic> map) {
    return Fornecedor(
      nome: map['nome'] ?? '',
      cnpj: map['cnpj'] ?? '',
      telefone: map['telefone'] ?? '',
      descricao: map['descricao'] ?? '',
    );
  }

  // Converte o objeto para JSON (necessário para salvar no Supabase)
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'descricao': descricao,
    };
  }
}

class FornecedorScreen extends StatefulWidget {
  const FornecedorScreen({super.key});

  @override
  _FornecedorScreenState createState() => _FornecedorScreenState();
}

class _FornecedorScreenState extends State<FornecedorScreen> {
  List<Fornecedor> fornecedores = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFornecedores();
  }

  // Busca os fornecedores do Supabase
  // Função para buscar fornecedores do Supabase
Future<void> _fetchFornecedores() async {
  try {
    // Recupera os fornecedores diretamente
    final List<dynamic> response = await Supabase.instance.client
        .from('fornecedor') // Nome da tabela no Supabase
        .select();

    // Se não houver erro, processa os dados
    setState(() {
      fornecedores = response.map((f) {
        return Fornecedor(
          nome: f['nome'] ?? '',
          cnpj: f['cnpj'] ?? '',
          telefone: f['telefone'] ?? '',
          descricao: f['descricao'] ?? '',
        );
      }).toList();
      isLoading = false;
    });
  } catch (e) {
    // Em caso de erro, exibe uma mensagem e atualiza o estado
    setState(() {
      isLoading = false;
    });

    _showErrorDialog('Erro ao carregar fornecedores: $e');
  }
}



  // Adiciona um novo fornecedor ao Supabase
  Future<void> _addFornecedor(Fornecedor fornecedor) async {
    try {
      final response = await Supabase.instance.client
          .from('fornecedor') // Nome da tabela no Supabase
          .insert(fornecedor.toJson());

      if (response.error != null) {
        throw Exception(response.error!.message);
      }

      // Atualiza a lista de fornecedores localmente
      setState(() {
        fornecedores.add(fornecedor);
      });
    } catch (e) {
      _showErrorDialog('Erro ao adicionar fornecedor: $e');
    }
  }

  // Mostra um diálogo de erro
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Scaffold(
    backgroundColor: const Color(0xFF393636),
    appBar: AppBar(
      title: Text(
        'FORNECEDOR',
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.07,
        ),
      ),
      backgroundColor: const Color(0xFF20805F),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : fornecedores.isEmpty
            ? const Center(
                child: Text(
                  'Nenhum fornecedor encontrado',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dois botões por linha
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2, // Ajusta a proporção do botão
                ),
                itemCount: fornecedores.length,
                itemBuilder: (context, index) {
                  final fornecedor = fornecedores[index];
                  return _buildFornecedorButton(fornecedor, screenWidth);
                },
              ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _showAddFornecedorDialog(context),
      backgroundColor: const Color(0xFF20805F),
      child: const Icon(Icons.add, color: Colors.white),
    ),
  );
}

Widget _buildFornecedorButton(Fornecedor fornecedor, double screenWidth) {
  // Trunca o nome se exceder 20 caracteres
  String nomeTruncado = fornecedor.nome.length > 20
      ? '${fornecedor.nome.substring(0, 20)}...'
      : fornecedor.nome;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 83, 79, 79),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Fornecedor2(fornecedor: fornecedor),
        ),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nome truncado com limite de 20 caracteres
        Text(
          nomeTruncado,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Exibição do CNPJ
        Text(
          'CNPJ: ${fornecedor.cnpj}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: screenWidth * 0.04,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        // Exibição do telefone
        Text(
          'Telefone: ${fornecedor.telefone}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: screenWidth * 0.04,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}


  void _showAddFornecedorDialog(BuildContext context) {
    String nome = '';
    String cnpj = '';
    String telefone = '';
    String descricao = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF393636),
          title: const Text('Adicionar Fornecedor', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Nome', (value) => nome = value),
              _buildTextField('CNPJ', (value) => cnpj = value),
              _buildTextField('Telefone', (value) => telefone = value),
              _buildTextField('Descrição', (value) => descricao = value),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                if (nome.isNotEmpty) {
                  final novoFornecedor = Fornecedor(
                    nome: nome,
                    cnpj: cnpj,
                    telefone: telefone,
                    descricao: descricao,
                  );
                  _addFornecedor(novoFornecedor);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, ValueChanged<String> onChanged) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
    );
  }
}
