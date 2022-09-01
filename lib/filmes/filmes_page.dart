import 'package:escribo03/filmes/filmes_provider.dart';
import 'package:escribo03/outros/my_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FilmesPage extends StatelessWidget {
  const FilmesPage({Key? key}) : super(key: key);

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
              itemBuilder: (ctx, i) => MyListItem(item: value.filmes[i])
            ) : CircularProgressIndicator();
          },
        );
      },
    );
  }
}