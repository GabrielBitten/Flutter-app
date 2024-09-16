class Projeto {
  String titulo;
  String descricao;
  String foto;
  String link;

  Projeto({
    required this.titulo,
    required this.descricao,
    required this.foto,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'foto': foto,
      'link': link,
    };
  }

  factory Projeto.fromMap(Map<String, dynamic> map) {
    return Projeto(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      foto: map['foto'] ?? '',
      link: map['link'] ?? '',
    );
  }
}
