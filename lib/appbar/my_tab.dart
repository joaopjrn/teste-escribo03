import 'package:flutter/cupertino.dart';

class MyTab extends StatelessWidget {
  final String txt;
  final IconData icon;

  const MyTab({Key? key, required this.txt, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 10,),
          Text(txt)
        ],
      ),
      );
  }
}