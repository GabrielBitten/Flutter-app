import "package:appflutter/categoria.dart";


class Projeto {
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
  });


  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'link': link,
      'imageUrl': imageUrl,
      'categoria': categoria.toString(), 
    };
  }


  factory Projeto.fromMap(Map<String, dynamic> map) {
    return Projeto(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      link: map['link'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      categoria: _categoryFromString(map['categoria'] ?? 'ProjectCategory.other'),
    );
  }

 
  static ProjectCategory _categoryFromString(String category) {
    return ProjectCategory.values.firstWhere(
      (e) => e.toString() == category,
      orElse: () => ProjectCategory.other,
    );
  }
}
