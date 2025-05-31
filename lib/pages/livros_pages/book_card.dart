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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Título: ${book.nome}', style: const TextStyle(color: Colors.black)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Autor: ${book.autor}', style: const TextStyle(color: Colors.black)),
                    Text('Qtd: ${book.quantidade}', style: const TextStyle(color: Colors.black)),
                    Text('Preço: R\$ ${book.preco.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(color: Colors.black)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CustomButton(onPressed: onEdit, icon: Icons.edit, small: true, label: '', outlined: true, color: Colors.yellow),
                        const SizedBox(width: 8),
                        CustomButton(onPressed: onDelete, icon: Icons.delete, small: true, label: '', outlined: true, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Imagem
              Container(
                width: 60,
                height: 90,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.hardEdge,
                child: hasImage ? Image.file(imageFile, fit: BoxFit.cover) : const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
