import 'package:flutter/material.dart';
import 'fornecedor.dart'; // Importar o modelo Fornecedor
import 'services/fornecedor_service.dart'; // Certifique-se de que o caminho está correto

const Color corTexto = Color.fromARGB(255, 255, 255, 255);
const Color corFundo = Color(0xFF393636);
const Color corAppBar = Color(0xFF20805F);

class Fornecedor2 extends StatefulWidget {
  final Fornecedor fornecedor; // Objeto fornecedor a ser editado

  // ignore: use_super_parameters
  const Fornecedor2({Key? key, required this.fornecedor}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Fornecedor2State createState() => _Fornecedor2State();
}

class _Fornecedor2State extends State<Fornecedor2> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preencher os campos com os dados do fornecedor
    _nomeController.text = widget.fornecedor.nome;
    _cnpjController.text = widget.fornecedor.cnpj;
    _telefoneController.text = widget.fornecedor.telefone;
    _descricaoController.text = widget.fornecedor.descricao;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'FORNECEDOR',
            style: TextStyle(
              color: corTexto,
              fontSize: screenWidth * 0.1,
            ),
          ),
        ),
        backgroundColor: corAppBar,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildTextField(_nomeController, 'Nome'),
            const SizedBox(height: 10),
            _buildTextField(_cnpjController, 'CNPJ'),
            const SizedBox(height: 10),
            _buildTextField(_telefoneController, 'Telefone'),
            const SizedBox(height: 10),
            _buildTextField(_descricaoController, 'Descrição', maxLines: 5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Atualizar fornecedor no Supabase
                    FornecedorService fornecedorService = FornecedorService();
                    try {
                      await fornecedorService.updateFornecedor(
                        widget.fornecedor.cnpj, // Usando CNPJ original
                        _nomeController.text,
                        _cnpjController.text,
                        _telefoneController.text,
                        _descricaoController.text,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true); // Indica sucesso ao voltar
                    } catch (e) {
                      _showErrorDialog('Erro ao salvar: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corAppBar,
                  ),
                  child: const Text('Salvar Alterações', style: TextStyle(color: corTexto)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Excluir fornecedor no Supabase
                    FornecedorService fornecedorService = FornecedorService();
                    try {
                      await fornecedorService.deleteFornecedor(widget.fornecedor.cnpj);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true); // Indica sucesso ao voltar
                    } catch (e) {
                      _showErrorDialog('Erro ao excluir: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Excluir Fornecedor', style: TextStyle(color: corTexto)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: corTexto),
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(color: corTexto),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro', style: TextStyle(color: Colors.red)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: corTexto)),
            ),
          ],
        );
      },
    );
  }
}
