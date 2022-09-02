import 'dart:convert';

import 'package:escribo03/personagens/personagem_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Personagens with ChangeNotifier {
  List<Personagem> _personagens = [];
  List<Personagem> get personagens => [..._personagens];
  bool isFetching = false;

  Future<List<Personagem>> fetchPersonagens() async {
    if(_personagens.isEmpty){
      if(!isFetching){
        print('fetching personagens');
        isFetching = true;
        var resp = await http.get(Uri.parse('https://swapi.dev/api/people/?format=json'));
        Map<String, dynamic> data = json.decode(resp.body);
        List results = data['results'];
        _personagens = results.map((item) => Personagem(
          id: item['height'] + item['birth_year'] + item['mass'], 
          nome: item['name'], 
          gender: (item['gender'] as String).contains('fem') ? Gender.Female :
          (item['gender'] as String).contains('n/a') ? Gender.Other : Gender.Male)).toList();
          print(personagens);
        isFetching = false;
        notifyListeners();
      }
    }
    return personagens;
  }

    String findNameById(String id) {
    return personagens.firstWhere((p) => p.id == id).nome;
  }

}