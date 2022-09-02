import 'package:escribo03/favoritos/favorito_model.dart';
import 'package:escribo03/filmes/filmes_provider.dart';
import 'package:escribo03/personagens/personagens_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemFavorito extends StatelessWidget {
  final Favorito item;
  const ItemFavorito({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _getTxt(){
      if(item.tipo == Tipo.Filme){
        return Provider.of<Filmes>(context).findNameById(int.parse(item.id));
      }else{
        return Provider.of<Personagens>(context).findNameById(item.id);
      }
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        side: BorderSide(
          color: item.tipo == Tipo.Filme ? Colors.red : Colors.green
        )
      ),
      child: ListTile(title: Text(_getTxt()),),
    );
  }
}