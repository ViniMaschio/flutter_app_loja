class UserModel {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final String createdAt;

  UserModel({required this.id, required this.nome, required this.email, required this.senha, required this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      senha: json['senha'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'email': email, 'createdAt': createdAt};
  }

  UserModel copyWith({String? id, String? nome, String? email, String? senha, String? createdAt}) {
    return UserModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
