import 'package:escribo03/favoritos/favoritos_provider.dart';
import 'package:escribo03/filmes/filme_model.dart';
import 'package:escribo03/personagens/personagem_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListItem extends StatefulWidget {
  final dynamic item;
  bool isFav;
  MyListItem({Key? key, required this.item, this.isFav = false}) : super(key: key);

  @override
  State<MyListItem> createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  Icon _getIcon(){
    if(widget.item is Personagem){
      switch ((widget.item as Personagem).gender) {
        case Gender.Female:
          return const Icon(Icons.female);
        case Gender.Male:
          return const Icon(Icons.male);
        default:
          return const Icon(Icons.cancel);
      }
    }
    if(widget.item is Filme){
      return const Icon(Icons.movie);
    }
    return const Icon(Icons.error);
  }

  Text _getTitle(){
    if(widget.item is Personagem){
      return Text((widget.item as Personagem).nome);
    }
    if(widget.item is Filme){
      return Text('Star Wars Episode ${(widget.item as Filme).id}\n${(widget.item as Filme).title}');
    }
    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    var fp = Provider.of<Favoritos>(context);
    widget.isFav = fp.isFavorite(widget.item.id.toString());
    return Card(
      child: ListTile(
        leading: _getIcon(),
        title: _getTitle(),
        trailing: IconButton(
          onPressed: () async {
            fp.toggleFavorite({
              '_id': widget.item.id,
              'tipo': widget.item is Filme ? 'filme' : 'personagem'
              }
            );
          }, 
          icon: Icon(widget.isFav ? Icons.star : Icons.star_border, color: Colors.yellow[700],)),
      ),
    );
  }
}