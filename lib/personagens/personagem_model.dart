enum Gender {
  Male,
  Female,
  Other
}

class Personagem {
  final String id;
  final String nome;
  final Gender gender;

  Personagem({required this.id, required this.nome, required this.gender});
}