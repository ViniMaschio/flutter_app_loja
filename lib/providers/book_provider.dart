import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loja_livros/models/book_model.dart';
import 'package:loja_livros/repositories/book_repository.dart';

class BookProvider extends ChangeNotifier {
  final BookRepository bookRepository;

  BookProvider({required this.bookRepository});

  List<BookModel>? _books;
  bool _isLoading = false;
  String? _errorMessage;

  List<BookModel>? get books => _books;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBooks() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final livros = await bookRepository.getBooks();
      _books = livros;
      if (livros.isEmpty) {
        _errorMessage = 'Nenhum livro encontrado';
      }
    } catch (e) {
      _errorMessage = 'Erro ao buscar livros';
    } finally {
      _isLoading = false;
      notifyListeners(); // última notificação
    }
  }

  Future<void> addBook(BookModel book, File imageFile) async {
    _isLoading = true;
    notifyListeners();
    try {
      await bookRepository.addBook(book, imageFile);
      await fetchBooks();
    } catch (e) {
      _errorMessage = 'Erro ao adicionar livro';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String id) async {
    await bookRepository.deleteBook(id);
    await fetchBooks();
  }

  Future<void> updateBook(String id, BookModel book, File img) async {
    await bookRepository.updateBook(id, book, img);
    await fetchBooks();
  }
}
