import 'package:escribo03/avatar/avatar_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.keyboard_backspace), 
                ),
              IconButton(
                onPressed: () async {
                  await Provider.of<MyAvatar>(context, listen: false).saveAvatar(await FluttermojiFunctions().encodeMySVGtoMap());
                  // print(await FluttermojiFunctions().encodeMySVGtoString());
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