import 'package:flutter/material.dart';
import 'services/gastos_service.dart'; // Importando o serviço de gastos

const Color corTexto = Color.fromARGB(255, 255, 255, 255);
const Color corFundo = Color(0xFF393636);
const Color corAppBar = Color(0xFF20805F);

class Gastos2 extends StatefulWidget {
  final Map<String, dynamic> gasto;

  const Gastos2({Key? key, required this.gasto}) : super(key: key);

  @override
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
                  onPressed: () async {
                    // Atualizar gasto no Supabase
                    GastoService gastoService = GastoService();
                    try {
                      await gastoService.updateGasto(
                        widget.gasto['id'], // Usando o ID do gasto original
                        double.parse(_valorController.text),
                        _descricaoController.text,
                      );
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
                    // Excluir gasto no Supabase
                    GastoService gastoService = GastoService();
                    try {
                      await gastoService.deleteGasto(widget.gasto['id']);
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
