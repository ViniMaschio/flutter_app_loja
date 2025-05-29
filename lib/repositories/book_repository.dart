import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_livros/models/book_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class BookRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'books';
  final uuid = const Uuid();

  Future<String> saveImageLocally(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final ext = path.extension(imageFile.path);
      final fileName = '${uuid.v4()}$ext';
      final localImagePath = path.join(directory.path, fileName);

      final savedImage = await imageFile.copy(localImagePath);
      return savedImage.path;
    } catch (e) {
      throw Exception('Erro ao salvar imagem localmente: $e');
    }
  }

  Future<void> addBook(BookModel book, File imageFile) async {
    try {
      final localPath = await saveImageLocally(imageFile);
      final newBook = book.copyWith(imagemUrl: localPath);
      await _firestore.collection(collectionPath).add(newBook.toJson());
    } catch (e) {
      throw Exception('Erro ao adicionar livro: $e');
    }
  }

  Future<List<BookModel>> getBooks() async {
    final querySnapshot = await _firestore.collection(collectionPath).get();

    return querySnapshot.docs.map((doc) => BookModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<void> updateBook(String id, BookModel updatedBook, File? newImageFile) async {
    try {
      final docRef = _firestore.collection(collectionPath).doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) throw Exception('Livro não encontrado');

      final data = docSnapshot.data();
      String? oldImagePath = data?['imagemUrl'];
      String? newImagePath = oldImagePath;

      if (newImageFile != null) {
        newImagePath = await saveImageLocally(newImageFile);
        if (oldImagePath != null) {
          final oldImageFile = File(oldImagePath);
          if (await oldImageFile.exists()) {
            await oldImageFile.delete();
          }
        }
      }

      final bookToUpdate = updatedBook.copyWith(imagemUrl: newImagePath);
      await docRef.update(bookToUpdate.toJson());
    } catch (e) {
      throw Exception('Erro ao atualizar livro: $e');
    }
  }

  /// Deleta livro e sua imagem local
  Future<void> deleteBook(String id) async {
    try {
      final doc = await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        final data = doc.data();
        final imagemPath = data?['imagemUrl'];

        // Deleta imagem local
        if (imagemPath != null) {
          final file = File(imagemPath);
          if (await file.exists()) {
            await file.delete();
          }
        }

        // Deleta o livro
        await _firestore.collection(collectionPath).doc(id).delete();
      }
    } catch (e) {
      throw Exception('Erro ao deletar livro: $e');
    }
  }
}
