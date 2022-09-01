import 'dart:io';

import 'package:escribo03/filmes/filmes_provider.dart';
import 'package:escribo03/helpers/http_override.dart';
import 'package:escribo03/homepage.dart';
import 'package:escribo03/personagens/personagens_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Filmes()),
        ChangeNotifierProvider(create: (context) => Personagens()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Teste Escribo 3',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}