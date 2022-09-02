import 'package:escribo03/appbar/my_tab.dart';
import 'package:escribo03/favoritos/favorito_model.dart';
import 'package:escribo03/favoritos/favoritos_provider.dart';
import 'package:escribo03/filmes/favoritos_page.dart';
import 'package:escribo03/filmes/filmes_page.dart';
import 'package:escribo03/personagens/personagens_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Star Wars Fans";

  // void _incrementCounter() {
  //   setState(() {
  //   });
  // }

  TabBar _myTabbar(){
    return const TabBar(tabs: <Widget> [
      MyTab(txt: 'Filmes', icon: Icons.movie),
      MyTab(txt: 'Personagens', icon: Icons.emoji_people),
      MyTab(txt: 'Favoritos', icon: Icons.star)
    ],
    isScrollable: true,);
  }

  AppBar _myAppbar(){
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[900],
      centerTitle: true,
      leading: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.public)),
      actions: [
        IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.person))
      ],
      bottom: _myTabbar(),
    );
  }

  Widget _body(){
    return const TabBarView(
      children: [
        Center(child: FilmesPage()),
        Center(child: PersonagensPage(),),
        Center(child: FavoritosPage(),)
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _myAppbar(),
        body: Center(
          child: FutureBuilder(
            future: Provider.of<Favoritos>(context, listen: false).fetchFavoritos(),
            builder: (ctx, AsyncSnapshot<List<Favorito>> snap) {
              var conn = snap.connectionState;
              print(conn);
              return conn == ConnectionState.done && !snap.hasError ? _body()
              : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}