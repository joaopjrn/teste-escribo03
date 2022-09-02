import 'package:escribo03/avatar/avatar_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:provider/provider.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 10,
          child: Container(
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              IconButton(
                onPressed: () async {
                  await Provider.of<MyAvatar>(context, listen: false).saveAvatar(await FluttermojiFunctions().encodeMySVGtoMap());
                }, 
                icon: const Icon(Icons.save), 
                ),
            ],),
          ),
        ),
        Expanded(flex: 35, child: FluttermojiCircleAvatar(
          backgroundColor: Colors.grey[200],
        )),
        Expanded(flex: 55, child: FluttermojiCustomizer()),
      ],);
  }
}