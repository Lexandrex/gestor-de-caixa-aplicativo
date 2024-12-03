import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/fornecedor_service.dart'; // Certifique-se de que o caminho está correto
import 'fornecedor.dart'; // Importar o modelo Fornecedor

const Color corTexto = Color.fromARGB(255, 255, 255, 255);
const Color corFundo = Color(0xFF393636);
const Color corAppBar = Color(0xFF20805F);

class Fornecedor2 extends StatefulWidget {
  final Fornecedor fornecedor; // Objeto fornecedor a ser editado

  const Fornecedor2({Key? key, required this.fornecedor}) : super(key: key);

  @override
  _Fornecedor2State createState() => _Fornecedor2State();
}

class _Fornecedor2State extends State<Fornecedor2> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController(); // Novo controlador para telefone
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
            _buildTextField(_telefoneController, 'Telefone'), // Campo para telefone
            const SizedBox(height: 10),
            _buildTextField(_descricaoController, 'Descrição', maxLines: 5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Lógica para salvar as alterações
                    FornecedorService fornecedorService = FornecedorService();
                    try {
                      await fornecedorService.updateFornecedor(
                        widget.fornecedor.cnpj, // Usando o CNPJ como identificador
                        _nomeController.text,
                        _cnpjController.text,
                        _telefoneController.text, // Adicionando telefone
                        _descricaoController.text,
                      );
                      Navigator.pop(context, true); // Retorna true para indicar que houve alteração
                    } catch (e) {
                      // Tratar erro
                      _showErrorDialog(e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corAppBar,
                  ),
                  child: const Text('Salvar Alterações', style: TextStyle(color: corTexto)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Lógica para excluir o fornecedor
                    FornecedorService fornecedorService = FornecedorService();
                    try {
                      await fornecedorService.deleteFornecedor(widget.fornecedor.cnpj); // Usando CNPJ para deletar
                      Navigator.pop(context, true); // Retorna true para indicar que o fornecedor foi excluído
                    } catch (e) {
                      // Tratar erro
                      _showErrorDialog(e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Cor para o botão de exclusão
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
        labelStyle: const TextStyle(color: corTexto), // Cor do texto do label
        border: const OutlineInputBorder(), // Adiciona borda ao campo
      ),
      style: const TextStyle(color: corTexto), // Cor do texto do campo
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