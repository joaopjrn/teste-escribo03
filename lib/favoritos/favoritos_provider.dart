import 'package:escribo03/db/db_helper.dart';
import 'package:escribo03/favoritos/favorito_model.dart';
import 'package:flutter/cupertino.dart';

class Favoritos with ChangeNotifier {
  List<Favorito> _favoritos = [];
  List<Favorito> get favoritos => [..._favoritos];
  bool _fetched = false;
  
  Future<List<Favorito>> fetchFavoritos() async {
    if(!_fetched){
    var data = await DBHelper.getData('favoritos');
    _favoritos = data.map((item) {
      return Favorito(
        id: item['_id'], 
        tipo: (item['tipo'] as String).contains('filme') ? Tipo.Filme : Tipo.Personagem
      );
    }).toList();
    _fetched = true;
    notifyListeners();
    }
    return favoritos;
  }


  bool isFavorite(String id){
    return favoritos.any((fav) => fav.id == id);
  }

  void toggleFavorite(dynamic item) async {
    var isFav = await DBHelper.findFav('favoritos', item['_id'].toString());
    await DBHelper.toggleFav(isFav, item);
    if(isFav){
      delFav(item);
    }else{
      addFav(item);
    }
  }

  void addFav(dynamic item){
    _favoritos.add(Favorito(id: item['_id'].toString(), tipo: (item['tipo'] as String).contains('fi') ? Tipo.Filme : Tipo.Personagem));
    notifyListeners();
  }
  void delFav(dynamic item){
    _favoritos.removeWhere((fav) => fav.id == item['_id'].toString());
    notifyListeners();
  }

}