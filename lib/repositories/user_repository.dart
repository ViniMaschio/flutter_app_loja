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
        final userWithId = user.copyWith(id: userId, isAdmin: false); // define isAdmin como false por padrão
        await _firestore.collection(collectionPath).doc(userId).set(userWithId.toJson());
      }
    } catch (e) {
      throw Exception('Erro ao adicionar usuário: $e');
    }
  }

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

  Future<UserModel?> getUserById(String id) async {
    try {
      final doc = await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Erro ao buscar usuário: $e');
    }
  }

  Future<void> updateUser(String id, UserModel user) async {
    try {
      await _firestore.collection(collectionPath).doc(id).update(user.toJson());
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao remover usuário: $e');
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
