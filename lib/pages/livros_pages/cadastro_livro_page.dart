import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/models/book_model.dart';
import 'package:loja_livros/providers/book_provider.dart';
import 'package:loja_livros/pages/livros_pages/custom_book_form.dart';

class CadastroLivroPage extends StatelessWidget {
  const CadastroLivroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Livro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: CustomBookForm(
          isLoading: bookProvider.isLoading,
          onSubmit: (BookModel book, imageFile) async {
            await bookProvider.addBook(book, imageFile);
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Livro cadastrado com sucesso!')));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
