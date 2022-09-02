import 'package:escribo03/favoritos/favoritos_page.dart';
import 'package:escribo03/filmes/filmes_page.dart';
import 'package:escribo03/personagens/personagens_page.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        Center(child: FilmesPage()),
        Center(child: PersonagensPage(),),
        Center(child: FavoritosPage(),)
      ]
    );
  }
}