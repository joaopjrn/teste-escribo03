import 'package:escribo03/outros/my_list_item.dart';
import 'package:escribo03/personagens/personagens_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class PersonagensPage extends StatelessWidget {
  const PersonagensPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Personagens>(context, listen: false).fetchPersonagens(),
      builder: (ctx, AsyncSnapshot snap) {
        var conn = snap.connectionState;
        print(conn);
        return Consumer<Personagens>(
          builder: (context, value, _) {
            return conn == ConnectionState.done ? ListView.builder(
              itemCount: value.personagens.length,
              itemBuilder: (ctx, i) => MyListItem(item: value.personagens[i])
            ) : CircularProgressIndicator();
          },
        );
      },
    );
  }
}