import 'package:escribo03/filmes/filme_model.dart';
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
      future: Provider.of<Filmes>(context).fetchFilmes(),
      builder: (ctx, AsyncSnapshot<List<Filme>> snap) {
        var conn = snap.connectionState;
        print(conn);
            return conn == ConnectionState.done ? ListView.builder(
              itemCount: snap.data?.length,
              itemBuilder: (ctx, i) => MyListItem(item: snap.data?[i])
            ) : CircularProgressIndicator();
          },
        );
  }
}