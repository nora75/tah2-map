// APIをたたく

import 'dart:html';
import 'package:flutter_web/material.dart';

class Api extends StatefulWidget {
  Api({Key key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
   
  final String title = "Api";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override

  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;   // 画面の横幅取得
    double height = MediaQuery.of(context).size.height;   // 画面の縦幅取得

    return Scaffold(

      // appbar : 上にあるバー
      appBar: AppBar(
        title: Text(title),
      ),

      body: Card(
        child: Column(
          children: <Widget>[
            _SearchBar(width),
            _PrintText(width, height),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget _SearchBar(width) {
  return Row(

  mainAxisAlignment: MainAxisAlignment.center,
        
  children: <Widget>[
    Container(
      width: width * 0.5,   // 横幅を画面の50%
      
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLength: 20,
      ),
      
    ),
    FlatButton(
      color: Colors.lightBlue[50],
      onPressed: () {
        // print("btn");
      },
      child: Text("検索"),
    )
  ],
);
}

Widget _PrintText(width, height) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,       
    children: <Widget>[
      Container(
        color: Colors.grey[300],
        width: width * 0.6,
        height: height * 0.7,
        child: Text(
          "TEST",
          style: TextStyle(
            fontSize: 50,
            color: Colors.grey[800],
          ),
        ),
        alignment: Alignment(0.0, 0.0),
      )
  ],
);
}