import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/models/book_model.dart';
import 'package:loja_livros/providers/book_provider.dart';
import 'package:loja_livros/widgets/custom_book_form.dart';

class EditarLivroPage extends StatelessWidget {
  final BookModel livroExistente;

  const EditarLivroPage({super.key, required this.livroExistente});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Livro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomBookForm(
          book: livroExistente,
          isLoading: bookProvider.isLoading,
          onSubmit: (livroAtualizado, novaImagem) async {
            await bookProvider.updateBook(livroExistente.id, livroAtualizado, novaImagem);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Livro atualizado com sucesso!')));
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
