import 'package:flutter/material.dart';
import 'services/gastos_service.dart'; // Importando o serviço de gastos

const Color corTexto = Color.fromARGB(255, 255, 255, 255);
const Color corFundo = Color(0xFF393636);
const Color corAppBar = Color(0xFF20805F);

class Gastos2 extends StatefulWidget {
  final Map<String, dynamic> gasto;
  final GastoService gastoService;

  const Gastos2({
    super.key, 
    required this.gasto,
    required this.gastoService,
  });

  @override
  // ignore: library_private_types_in_public_api
  _Gastos2State createState() => _Gastos2State();
}

class _Gastos2State extends State<Gastos2> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valorController.text = widget.gasto['quantidade'].toString();
    _descricaoController.text = widget.gasto['descricao'] ?? '';
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
            'GASTO',
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
            _buildTextField(_valorController, 'Valor', keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            _buildTextField(_descricaoController, 'Descrição', maxLines: 5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corAppBar,
                  ),
                  onPressed: () async {
                    try {
                      // Atualiza os dados usando o service
                      await widget.gastoService.updateGasto(
                        widget.gasto['id'],
                        valor: double.parse(_valorController.text),
                        descricao: _descricaoController.text,
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context); // Volta para a tela anterior
                    } catch (e) {
                      print('Erro ao atualizar gasto: $e');
                      // Mostra mensagem de erro
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao atualizar: $e')),
                      );
                    }
                  },
                  child: const Text('Salvar Alterações', style: TextStyle(color: corTexto)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Usa o service que foi passado como parâmetro
                      await widget.gastoService.deleteGasto(widget.gasto['id']);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true); // Indica sucesso ao voltar
                    } catch (e) {
                      _showErrorDialog('Erro ao excluir: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Excluir Gasto', style: TextStyle(color: corTexto)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
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
