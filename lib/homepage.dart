import 'package:escribo03/appbar/my_tab.dart';
import 'package:escribo03/avatar/avatar_page.dart';
import 'package:escribo03/favoritos/favorito_model.dart';
import 'package:escribo03/favoritos/favoritos_provider.dart';
import 'package:escribo03/filmes/favoritos_page.dart';
import 'package:escribo03/filmes/filmes_page.dart';
import 'package:escribo03/personagens/personagens_page.dart';
import 'package:escribo03/tabs/tabs_page.dart';
import 'package:escribo03/webview/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Page {
  Tabs,
  WebView,
  Avatar
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Star Wars Fans";
  Page page = Page.Tabs;

  void _setPage(Page p) {
    setState(() {
      if (p == page) {
        page = Page.Tabs;
      } else {
        page = p;
      }
      _setTitle();
    });
  }

  void _setTitle(){
    switch (page) {
      case Page.WebView:
        title = "Website";
        break;
      case Page.Avatar:
        title = "Customize seu Avatar!";
        break;
      default:
      title = "Star Wars Fans";
    }
  }

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
          onPressed: ()=>_setPage(Page.WebView), 
          icon: const Icon(Icons.public)),
      actions: [
        IconButton(
          onPressed: ()=>_setPage(Page.Avatar), 
          icon: const Icon(Icons.person))
      ],
      bottom: page == Page.Tabs ? _myTabbar() : null,
    );
  }

  Widget _body(){
    switch (page) {
      case Page.WebView:
        return const WebviewPage();
      case Page.Avatar:
        return const AvatarPage();
      default:
        return const TabsPage();
    }
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