import 'package:escribo03/filmes/filme_model.dart';
import 'package:flutter/cupertino.dart';

class Filmes with ChangeNotifier {
  List<Filme> _filmes = [];
  List<Filme> get filmes => [..._filmes];

  fetchFilmes(){
    
  }
}