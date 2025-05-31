class UserModel {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final String createdAt;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.createdAt,
    this.isAdmin = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      senha: json['senha'] ?? '',
      createdAt: json['createdAt'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'email': email, 'createdAt': createdAt, 'isAdmin': isAdmin};
  }

  UserModel copyWith({String? id, String? nome, String? email, String? senha, String? createdAt, bool? isAdmin}) {
    return UserModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      createdAt: createdAt ?? this.createdAt,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
