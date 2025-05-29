// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_livros/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'users';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUser(UserModel user) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: user.email, password: user.senha);
      final userId = userCredential.user?.uid;
      if (userId != null) {
        await _firestore.collection(collectionPath).doc(userId).set(user.copyWith(id: userId).toJson());
      }
    } catch (e) {
      throw Exception('Erro ao adicionar usuário: $e');
    }
  }

  /// Retorna todos os usuários em tempo real
  Stream<List<UserModel>> getAllUsers() {
    try {
      return _firestore.collection(collectionPath).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return UserModel.fromJson(doc.data());
        }).toList();
      });
    } catch (e) {
      throw Exception('Erro ao buscar usuários: $e');
    }
  }

  /// Busca usuário pelo ID
  Future<UserModel?> getUserById(String id) async {
    try {
      final doc = await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Erro ao adicionar usuário: $e');
    }
  }

  Future<void> updateUser(String id, UserModel user) async {
    try {
      await _firestore.collection(collectionPath).doc(id).update(user.toJson());
      //print('Usuário atualizado com sucesso: ${user.nome}');
    } catch (e) {
      throw Exception('Erro ao adicionar usuário: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
      print('Usuário removido com sucesso: $id');
    } catch (e) {
      throw Exception('Erro ao adicionar usuário: $e');
    }
  }

  Future<UserModel?> login(String email, String senha) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: senha);

    final uid = userCredential.user?.uid;
    if (uid != null) {
      final doc = await _firestore.collection(collectionPath).doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection(collectionPath).doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    }
    return null;
  }
}
