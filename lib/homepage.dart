import 'package:escribo03/appbar/my_tab.dart';
import 'package:flutter/material.dart';

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
          icon: Icon(Icons.public)),
      actions: [
        IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.person))
      ],
      bottom: _myTabbar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _myAppbar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}