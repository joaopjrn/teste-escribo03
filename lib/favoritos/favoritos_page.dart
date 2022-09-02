import 'package:escribo03/favoritos/favoritos_provider.dart';
import 'package:escribo03/favoritos/item_favorito.dart';
import 'package:escribo03/filmes/filmes_provider.dart';
import 'package:escribo03/personagens/personagens_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pf = Provider.of<Filmes>(context);
    var pp = Provider.of<Personagens>(context);
    var pfav = Provider.of<Favoritos>(context);

    if(pf.filmes.isEmpty && !pf.isFetching) Provider.of<Filmes>(context, listen: false).fetchFilmes();
    if(pp.personagens.isEmpty && !pp.isFetching) Provider.of<Personagens>(context, listen: false).fetchPersonagens();
    bool loaded = pf.filmes.isNotEmpty && pp.personagens.isNotEmpty;

    return loaded ? ListView.builder(
      itemCount: pfav.favoritos.length,
      itemBuilder: (ctx, i) {
        return ItemFavorito(item: pfav.favoritos[i]);
      }
    ) : CircularProgressIndicator();
  }
}