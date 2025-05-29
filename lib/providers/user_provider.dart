import 'package:flutter/material.dart';
import 'package:loja_livros/models/users_model.dart';
import 'package:loja_livros/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  UserProvider({required this.userRepository});

  final UserRepository userRepository;

  List<UserModel> _users = [];
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  List<UserModel> get users => _users;
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> buscarTodosUsuarios() async {
    _setLoading(true);
    _setError(null);

    try {
      final result = await userRepository.getAllUsers().first;
      _users = result;
    } catch (e) {
      _setError('Erro ao buscar usuários: $e');
      _users = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> adicionarUsuario(UserModel user) async {
    _setLoading(true);
    _setError(null);

    try {
      await userRepository.addUser(user);
    } catch (e) {
      _setError('Erro ao adicionar usuário: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> atualizarUsuario(String id, UserModel user) async {
    _setLoading(true);
    _setError(null);

    try {
      await userRepository.updateUser(id, user);
      await buscarTodosUsuarios();
    } catch (e) {
      _setError('Erro ao atualizar usuário: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removerUsuario(String id) async {
    _setLoading(true);
    _setError(null);

    try {
      await userRepository.deleteUser(id);
      _users.removeWhere((user) => user.id == id);
      notifyListeners();
    } catch (e) {
      _setError('Erro ao remover usuário: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<UserModel?> buscarUsuarioPorId(String id) async {
    try {
      return await userRepository.getUserById(id);
    } catch (e) {
      _setError('Erro ao buscar usuário: $e');
      return null;
    }
  }

  /// LOGIN
  Future<bool> login(String email, String senha) async {
    _setLoading(true);
    _setError(null);

    try {
      final user = await userRepository.login(email, senha);
      if (user != null) {
        _currentUser = user;
        notifyListeners();
        return true;
      } else {
        _setError('Usuário não encontrado');
        return false;
      }
    } catch (e) {
      _setError('Erro ao fazer login: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await userRepository.logout();
    _currentUser = null;
    notifyListeners();
  }

  /// BUSCAR USUÁRIO LOGADO
  Future<void> verificarUsuarioLogado() async {
    _setLoading(true);
    try {
      final user = await userRepository.getCurrentUser();
      _currentUser = user;
    } catch (e) {
      _setError('Erro ao verificar usuário logado');
    } finally {
      _setLoading(false);
    }
  }
}
