import 'package:escribo03/favoritos/favoritos_provider.dart';
import 'package:escribo03/favoritos/item_favorito.dart';
import 'package:escribo03/filmes/filmes_provider.dart';
import 'package:escribo03/personagens/personagens_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Favoritos>(
      builder: (context, value, _) {
        if(value.filmesState!.shouldFetch()) value.filmesState!.fetchFilmes();
        if(value.personagensState!.shouldFetch()) value.personagensState!.fetchPersonagens();
        bool loaded = value.filmesState!.filmes.isNotEmpty && value.personagensState!.personagens.isNotEmpty;

        return loaded && value.favoritos.isNotEmpty ? ListView.builder(
          itemCount: value.favoritos.length,
          itemBuilder: (ctx, i) {
            return ItemFavorito(item: value.favoritos[i]);
          }
        ) 
        : loaded && value.favoritos.isEmpty 
        ? const Center(child: Text('Nenhum favorito adicionado!'),) : const CircularProgressIndicator();
      } ,
    );
  }
}