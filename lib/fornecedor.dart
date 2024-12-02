import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/fornecedor_service.dart';
import 'fornecedor2.dart';

class Fornecedor extends StatefulWidget {
  const Fornecedor({super.key});

  @override
  _FornecedorState createState() => _FornecedorState();
}

class _FornecedorState extends State<Fornecedor> {
  List<String> fornecedores = []; // Lista para armazenar os nomes dos fornecedores
  bool isLoading = true; // Flag para controlar o carregamento

  @override
  void initState() {
    super.initState();
    _fetchFornecedores(); // Busca os fornecedores ao iniciar o estado
  }

  // Função para buscar fornecedores
  Future<void> _fetchFornecedores() async {
    try {
      FornecedorService fornecedorService = FornecedorService();
      List<dynamic> fetchedFornecedores = await fornecedorService.getFornecedores();

      setState(() {
        fornecedores = fetchedFornecedores.map((f) => f['nome'] as String).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: Text('Erro ao carregar fornecedores: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF393636), // Cor de fundo
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'FORNECEDOR',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.1,
            ),
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
          : Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: fornecedores.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum fornecedor encontrado',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: fornecedores.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
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
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color.fromARGB(255, 83, 79, 79),
                                    border: Border.all(color: const Color(0xFF20805F)),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: screenWidth * 0.7,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(280, 73),
                                      backgroundColor: const Color.fromARGB(255, 83, 79, 79),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Fornecedor2(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      fornecedores[index],
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFornecedorDialog(context);
        },
        backgroundColor: const Color(0xFF20805F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Função para mostrar o diálogo de adicionar fornecedor
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
          content: SizedBox(
            height: 250,
            child: Column(
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
                  onChanged: (value) => nome = value,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'CNPJ',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => cnpj = value,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => telefone = value,
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
                  onChanged: (value) => descricao = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () async {
                if (nome.isNotEmpty && cnpj.isNotEmpty && telefone.isNotEmpty && descricao.isNotEmpty) {
                  try {
                    FornecedorService fornecedorService = FornecedorService();
                    await fornecedorService.createFornecedor(nome, cnpj, telefone, descricao);

                    setState(() {
                      fornecedores.add(nome);
                    });

                    Navigator.of(context).pop();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Erro'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: const Text('Adicionar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
