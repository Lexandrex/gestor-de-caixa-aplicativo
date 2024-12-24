import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vendas_service.dart'; // Serviço para atualizar a venda

const Color corTexto = Color.fromARGB(255, 255, 255, 255);
const Color corFundo = Color(0xFF393636);
const Color corAppBar = Color(0xFF20805F);

class Troca2 extends StatefulWidget {
  final Map<String, dynamic> troca;

  const Troca2({Key? key, required this.troca}) : super(key: key);

  @override
  _Troca2State createState() => _Troca2State();
}

class _Troca2State extends State<Troca2> {
  final TextEditingController _quantidade12Controller = TextEditingController();
  final TextEditingController _quantidade20Controller = TextEditingController();
  final TextEditingController _formaPagamentoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quantidade12Controller.text = widget.troca['quantidade_12'].toString();
    _quantidade20Controller.text = widget.troca['quantidade_20'].toString();
    _formaPagamentoController.text = widget.troca['formaPagamento'] ?? '';
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
            'TROCA',
            style: TextStyle(
              color: corTexto,  // Aqui alteramos a cor do texto da AppBar
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
            _buildTextField(_quantidade12Controller, 'Quantidade 12', keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            _buildTextField(_quantidade20Controller, 'Quantidade 20', keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            _buildTextField(_formaPagamentoController, 'Forma de Pagamento'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Atualizar a venda no Supabase
                    ApiService vendasService = ApiService();
                    try {
                      // Atualiza os campos específicos da venda
                      await vendasService.updateVendaCampos(
                        widget.troca['id_venda'], // Usando o ID da venda original
                        quantidade12: int.parse(_quantidade12Controller.text),
                        quantidade20: int.parse(_quantidade20Controller.text),
                        formaPagamento: _formaPagamentoController.text,
                      );
                      Navigator.pop(context, true); // Indica sucesso ao voltar
                    } catch (e) {
                      _showErrorDialog('Erro ao salvar: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corAppBar,
                  ),
                  child: const Text('Salvar Alterações', style: TextStyle(color: corTexto)), // Texto branco no botão
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Excluir a venda no Supabase
                    ApiService vendasService = ApiService();
                    try {
                      await vendasService.deleteVendas(widget.troca['id_venda']);
                      Navigator.pop(context, true); // Indica sucesso ao voltar
                    } catch (e) {
                      _showErrorDialog('Erro ao excluir: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Excluir Troca', style: TextStyle(color: corTexto)), // Texto branco no botão
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
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: corTexto),  // Cor do texto do label
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      style: const TextStyle(color: corTexto),  // Cor do texto dentro do campo
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro', style: TextStyle(color: corTexto)), // Título do alerta com texto branco
          content: Text(message, style: const TextStyle(color: corTexto)), // Mensagem de erro com texto branco
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: corTexto)), // Botão "OK" com texto branco
            ),
          ],
        );
      },
    );
  }
}
