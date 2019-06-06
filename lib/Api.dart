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

    return Scaffold(

      // appbar : 上にあるバー
      appBar: AppBar(
        title: Text(title),
      ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width * 0.5,   // 横幅を画面の50%
              
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 20,
              ),
            ),
            
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
