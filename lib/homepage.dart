import 'dart:convert';

import 'package:escribo03/appbar/my_tab.dart';
import 'package:escribo03/avatar/avatar_page.dart';
import 'package:escribo03/avatar/avatar_provider.dart';
import 'package:escribo03/favoritos/favorito_model.dart';
import 'package:escribo03/favoritos/favoritos_provider.dart';
import 'package:escribo03/favoritos/favoritos_page.dart';
import 'package:escribo03/filmes/filmes_page.dart';
import 'package:escribo03/personagens/personagens_page.dart';
import 'package:escribo03/tabs/tabs_page.dart';
import 'package:escribo03/webview/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;

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
    Provider.of<MyAvatar>(context, listen: false).fetchAvatar();
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[900],
      centerTitle: true,
      leading: IconButton(
          onPressed: ()=>_setPage(Page.WebView), 
          icon: const Icon(Icons.public)),
      actions: [
        Consumer<MyAvatar>(
          builder: (context, value, _) {
            print('teste');
            return InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: ()=>_setPage(Page.Avatar),
            child: svg.SvgPicture.string(
              FluttermojiFunctions().decodeFluttermojifromString(jsonEncode(value.defAavatar)),
              height: 40,
              ),
          );
          },
        )
        // FutureBuilder(
        //   future: Provider.of<MyAvatar>(context).fetchAvatar(),
        //   builder: (ctx, AsyncSnapshot snap) {
        //     var conn = snap.connectionState;
        //     print('avatar');
        //     print(conn);
        //     return conn == ConnectionState.done ? Consumer<MyAvatar>(
        //       builder: (context, value, _) {
        //         return InkWell(
        //         borderRadius: BorderRadius.circular(50),
        //         onTap: ()=>_setPage(Page.Avatar),
        //         child: svg.SvgPicture.string(
        //           FluttermojiFunctions().decodeFluttermojifromString(snap.data),
        //           height: 40,
        //           ),
        //       );
        //       },
        //     ) : Icon(Icons.person);
        //   //   return IconButton(
        //   // onPressed: ()=>_setPage(Page.Avatar), 
        //   // icon: const Icon(Icons.person));
        //   },
        // )
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