import 'dart:convert';

import 'package:escribo03/filmes/filme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Filmes with ChangeNotifier {
  List<Filme> _filmes = [];
  List<Filme> get filmes => [..._filmes];
  bool isFetching = false;
  bool firstLoad = false;

  Future fetchFilmes() async {
    if(_filmes.isEmpty){
      if(!isFetching){
        print('start fetching2');
        isFetching = true;
        var resp = await http.get(Uri.parse('https://swapi.dev/api/films/?format=json'));
        print('done fetching');
        Map<String, dynamic> data = json.decode(resp.body);
        List results = data['results'];
        _filmes = results.map((item) => Filme(id: item['episode_id'], title: item['title'])).toList();
        print(_filmes);
        isFetching = false;
        firstLoad = true;
        notifyListeners();
      }
    }
  }
}