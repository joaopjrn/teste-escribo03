import 'dart:convert';

import 'package:escribo03/filmes/filme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Filmes with ChangeNotifier {
  List<Filme> _filmes = [];
  List<Filme> get filmes => [..._filmes];
  bool isFetching = false;
  bool firstLoad = false;

  Future<List<Filme>> fetchFilmes() async {
    if(_filmes.isEmpty){
      if(!isFetching){
        isFetching = true;
        var resp = await http.get(Uri.parse('https://swapi.dev/api/films/?format=json'));
        Map<String, dynamic> data = json.decode(resp.body);
        List results = data['results'];
        _filmes = results.map((item) => Filme(id: item['episode_id'], title: item['title'])).toList();
        isFetching = false;
        firstLoad = true;
        notifyListeners();
      }
    }
        return filmes;
  }

  String findNameById(int id) {
    return filmes.firstWhere((filme) => filme.id == id).title;
  }
}