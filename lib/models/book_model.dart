class BookModel {
  final String id;
  final String nome;
  final String autor;
  final String imagemUrl;
  final double preco;
  final int quantidade;

  BookModel({
    required this.id,
    required this.nome,
    required this.autor,
    required this.imagemUrl,
    required this.preco,
    required this.quantidade,
  });

  factory BookModel.fromJson(Map<String, dynamic> json, String id) {
    return BookModel(
      id: id,
      nome: json['nome'],
      autor: json['autor'],
      imagemUrl: json['imagemUrl'],
      preco: (json['preco'] as num).toDouble(),
      quantidade: json['quantidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'nome': nome, 'autor': autor, 'imagemUrl': imagemUrl, 'preco': preco, 'quantidade': quantidade};
  }

  BookModel copyWith({String? id, String? nome, String? autor, String? imagemUrl, double? preco, int? quantidade}) {
    return BookModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      autor: autor ?? this.autor,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      preco: preco ?? this.preco,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}
