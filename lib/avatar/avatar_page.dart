import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.keyboard_backspace), 
              ),
            IconButton(
              onPressed: ()async{
                print(await FluttermojiFunctions().encodeMySVGtoMap());
              }, 
              icon: Icon(Icons.save), 
              ),
          ],),
        ),
        FluttermojiCircleAvatar(),
        FluttermojiCustomizer(),
      ],);
  }
}