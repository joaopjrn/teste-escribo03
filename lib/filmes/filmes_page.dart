import 'package:escribo03/filmes/filmes_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FilmesPage extends StatefulWidget {
  const FilmesPage({Key? key}) : super(key: key);

  @override
  State<FilmesPage> createState() => _FilmesPageState();
}

class _FilmesPageState extends State<FilmesPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Filmes>(context, listen: false).fetchFilmes(),
      builder: (ctx, AsyncSnapshot snap) {
        var conn = snap.connectionState;
        print(conn);
        return Consumer<Filmes>(
          builder: (context, value, _) {
            return conn == ConnectionState.done ? ListView.builder(
              itemCount: value.filmes.length,
              itemBuilder: (ctx, i) => Text(value.filmes[i].title)
            ) : CircularProgressIndicator();
          },
        );
      },
    );
  }
}