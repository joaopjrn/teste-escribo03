import 'package:escribo03/outros/my_list_item.dart';
import 'package:escribo03/personagens/personagem_model.dart';
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
      future: Provider.of<Personagens>(context).fetchPersonagens(),
      builder: (ctx, AsyncSnapshot<List<Personagem>> snap) {
        var conn = snap.connectionState;
            return conn == ConnectionState.done ? ListView.builder(
              itemCount: snap.data?.length,
              itemBuilder: (ctx, i) => MyListItem(item: snap.data?[i])
            ) : CircularProgressIndicator();
          },
        );

  }
}