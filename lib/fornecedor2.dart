import 'package:flutter/material.dart';

const Color corTexto = Color.fromARGB(255, 255, 255, 255);
const Color corFundo = Color(0xFF393636);
const Color corAppBar = Color(0xFF20805F);
const Color corIcone = Color.fromARGB(255, 83, 79, 79);

class Fornecedor2 extends StatefulWidget {
  const Fornecedor2({super.key});

  @override
  _Fornecedor2State createState() => _Fornecedor2State();
}

class _Fornecedor2State extends State<Fornecedor2> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  String _nome = ''; // Para armazenar o nome

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: corFundo, // Cor de fundo ajustada
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0), // Adiciona padding ao título
          child: Text(
            'FORNECEDOR',
            style: TextStyle(
              color: corTexto, // Cor do texto do título
              fontSize: screenWidth * 0.1, // Tamanho de fonte responsivo
            ),
          ),
        ),
        backgroundColor: corAppBar, // Cor de fundo
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Volta para a tela anterior
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _nome.isNotEmpty ? _nome : 'Nome não inserido',
              style: const TextStyle(
                  color: corTexto, fontSize: 20), // Cor do texto
            ),
            const SizedBox(height: 20),
            _buildTextField(_nomeController, 'Nome'),
            const SizedBox(height: 10),
            _buildTextField(_cpfController, 'CPF/CNPJ'),
            const SizedBox(height: 10),
            _buildTextField(_descricaoController, 'Descrição', maxLines: 5),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _nome = _nomeController.text; // Atualiza o nome
                });
                // Aqui você pode adicionar lógica para salvar as alterações, se necessário
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: corAppBar, // Cor de fundo do botão
              ),
              child: const Text('Salvar Alterações',
                  style: TextStyle(color: corTexto)), // Cor do texto do botão
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
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
}
