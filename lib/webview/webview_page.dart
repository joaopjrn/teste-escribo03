import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  int p = 0;

  @override
  Widget build(BuildContext context) {
    _updateProgress(int progress){
      setState(() {
        print('updating');
        p = progress;
      });
    }

    return Column(children: [
      Expanded(
        flex: p < 99 ? 1 : 0,
        child: Row(children: [
          Expanded(flex: p, child: Container(color: Colors.blue[300],)),
          Expanded(flex: 100 - p, child: Container(color: Colors.blue[50],))
        ],)
      ),
      Expanded(
        flex: 150,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse('https://www.starwars.com/community')),
          onProgressChanged: (controller, progress) {
            print(progress);
            if(p < 99){
              _updateProgress(progress);
            }
          },
        ),
      )
    ],);
  }
}