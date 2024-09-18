import 'package:appflutter/categoria.dart';
import 'package:uuid/uuid.dart'; // Importa a biblioteca uuid

class Projeto {
  String id; // Campo id para identificar o projeto
  String titulo;
  String descricao;
  String link;
  String imageUrl;
  ProjectCategory categoria;

  Projeto({
    required this.titulo,
    required this.descricao,
    required this.link,
    required this.imageUrl,
    required this.categoria,
  }) : id = Uuid().v4(); // Gera um novo UUID automaticamente

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Inclui o ID no mapa
      'titulo': titulo,
      'descricao': descricao,
      'link': link,
      'imageUrl': imageUrl,
      'categoria': categoria.name, // Salva apenas o nome da categoria
    };
  }

  factory Projeto.fromMap(Map<String, dynamic> map) {
    return Projeto(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      link: map['link'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      categoria: ProjectCategory.values.firstWhere(
        (e) => e.name == map['categoria'],
        orElse: () => ProjectCategory.outros,
      ),
    )..id = map['id'] ?? Uuid().v4(); // Gera um novo UUID se o ID não estiver no mapa
  }
}
