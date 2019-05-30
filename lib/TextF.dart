import 'dart:html';
import 'package:flutter_web/material.dart';

class TextF extends StatefulWidget {
  TextF({Key home}) : super(key: home);

  @override
  _TextFState createState() => _TextFState();
}

class _TextFState extends State<TextF> {

  final String title = "TextF";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override

  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        // 画面に変数の中身表示
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.yellow[500],
                border: Border.all(
                  width: 4.0,
                  color: Colors.black
                ),
                borderRadius: BorderRadius.all(
                Radius.circular(5.0)
        )
        ),
        child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none
        ), //テキストフォーム下の下線
        keyboardType: TextInputType.multiline, 
        maxLines: null,
        textAlign: TextAlign.center,
        ),
      ),
      ],
    ),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
  }
}