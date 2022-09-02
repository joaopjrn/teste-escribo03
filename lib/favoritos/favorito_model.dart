enum Tipo {
  Filme,
  Personagem
}

class Favorito {
  final String id;
  final Tipo tipo;
  bool isFavorite;

  Favorito({required this.id, required this.tipo, this.isFavorite = false});
}