import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_livros/models/book_model.dart';
import 'package:loja_livros/widgets/custom_button.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BookCard({super.key, required this.book, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final imageFile = File(book.imagemUrl);
    final hasImage = imageFile.existsSync();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  hasImage
                      ? Image.file(imageFile, width: 100, height: 140, fit: BoxFit.cover)
                      : Container(
                        width: 100,
                        height: 140,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported, size: 40),
                      ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.nome, style: Theme.of(context).textTheme.titleLarge),
                  Text('Autor: ${book.autor}', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Preço: R\$ ${book.preco.toStringAsFixed(2)}'),
                  Text('Qtd: ${book.quantidade}'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: CustomButton(label: 'Editar', onPressed: onEdit, isLoading: false, small: true, outlined: true)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(label: 'Excluir', onPressed: onDelete, isLoading: false, small: true, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
