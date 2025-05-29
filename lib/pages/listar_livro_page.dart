import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/providers/book_provider.dart';
import 'package:loja_livros/widgets/book_card.dart';
import 'package:loja_livros/widgets/custom_drawer.dart'; // <== IMPORTANTE

class ListarLivroPage extends StatefulWidget {
  const ListarLivroPage({super.key});

  @override
  State<ListarLivroPage> createState() => _ListarLivroPageState();
}

class _ListarLivroPageState extends State<ListarLivroPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<BookProvider>(context, listen: false);
      provider.fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros Cadastrados'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Cadastrar Livro',
            onPressed: () => Navigator.pushNamed(context, '/cadastro_livro'),
          ),
        ],
      ),
      drawer: const CustomDrawer(), // <== AQUI ESTÁ O DRAWER
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, _) {
          final livros = bookProvider.books;

          if (bookProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (livros == null || livros.isEmpty) {
            return const Center(child: Text('Nenhum livro encontrado'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await Provider.of<BookProvider>(context, listen: false).fetchBooks();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: livros.length,
              itemBuilder: (_, index) {
                final livro = livros[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: BookCard(
                    book: livro,
                    onEdit: () => Navigator.pushNamed(context, '/editar_livro', arguments: livro),
                    onDelete: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Confirmar exclusão'),
                              content: const Text('Deseja realmente excluir este livro?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
                              ],
                            ),
                      );

                      if (confirm == true && mounted) {
                        await Provider.of<BookProvider>(context, listen: false).deleteBook(livro.id);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Livro excluído com sucesso!')));
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
