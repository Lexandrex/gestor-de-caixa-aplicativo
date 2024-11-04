import 'package:flutter/material.dart';
import 'package:flutter_application_1/fornecedor2.dart'; // Certifique-se de que o arquivo fornecedor2.dart exista

class Fornecedor extends StatefulWidget {
  const Fornecedor({super.key});

  @override
  _FornecedorState createState() => _FornecedorState();
}

class _FornecedorState extends State<Fornecedor> {
  List<String> fornecedores =
      []; // Lista para armazenar os nomes dos fornecedores

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF393636), // Cor de fundo
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0), // Adiciona padding ao título
          child: Text(
            'FORNECEDOR',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: screenWidth * 0.1, // Tamanho de fonte responsivo
            ),
          ),
        ),
        backgroundColor: const Color(0xFF20805F), // Cor de fundo
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Volta para a tela anterior
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: fornecedores.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navega para a página Fornecedor2 ao clicar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Fornecedor2(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Círculo
                      Container(
                        width: 75, // Largura do círculo
                        height: 75, // Altura do círculo
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(
                              255, 83, 79, 79), // Cor do círculo
                          border: Border.all(
                            color: const Color(0xFF20805F), // Borda verde
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 20), // Espaçamento entre o círculo e o botão
                      // Botão
                      SizedBox(
                        width: screenWidth * 0.7, // Largura responsiva do botão
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(280, 73),
                            backgroundColor:
                                const Color.fromARGB(255, 83, 79, 79),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0.0),
                                bottomLeft: Radius.circular(0.0),
                                topRight: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Ação do botão, também pode ser deixado vazio
                          },
                          child: Text(
                            fornecedores[index],
                            style: const TextStyle(
                                color:
                                    Colors.white), // Exibe o nome do fornecedor
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFornecedorDialog(
              context); // Chama a função para mostrar o formulário
        },
        backgroundColor: const Color(0xFF20805F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showAddFornecedorDialog(BuildContext context) {
    String nome = '';
    String cpf = '';
    String descricao = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF393636),
          title: const Text(
            'Adicionar Fornecedor',
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    nome = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    cpf = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    descricao = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                if (nome.isNotEmpty && cpf.isNotEmpty && descricao.isNotEmpty) {
                  setState(() {
                    fornecedores.add(nome); // Adiciona o fornecedor à lista
                  });
                  print('Fornecedor Adicionado: $nome, $cpf, $descricao');
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
