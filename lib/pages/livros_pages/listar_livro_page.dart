import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/providers/book_provider.dart';
import 'package:loja_livros/pages/livros_pages/book_card.dart';
import 'package:loja_livros/widgets/custom_drawer.dart';

class ListarLivroPage extends StatefulWidget {
  const ListarLivroPage({super.key});

  @override
  State<ListarLivroPage> createState() => _ListarLivroPageState();
}

class _ListarLivroPageState extends State<ListarLivroPage> {
  bool _didFetch = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetch) {
      Future.microtask(() => Provider.of<BookProvider>(context, listen: false).fetchBooks());
      _didFetch = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    final livros = bookProvider.books;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Livros'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Cadastrar Livro',
            onPressed: () => Navigator.pushNamed(context, '/cadastro_livro'),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body:
          bookProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : (livros == null || livros.isEmpty)
              ? const Center(child: Text('Nenhum livro encontrado'))
              : RefreshIndicator(
                onRefresh: () => context.read<BookProvider>().fetchBooks(),
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
                                  content: Text('Deseja realmente excluir o livro "${livro.nome}"?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
                                  ],
                                ),
                          );

                          if (confirm == true && context.mounted) {
                            await context.read<BookProvider>().deleteBook(livro.id);
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text('Livro "${livro.nome}" excluído com sucesso!')));
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
