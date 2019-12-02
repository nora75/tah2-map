// ホームページ
// 各ページへのリンク

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // StatefulWidgetはbuildメソッドを直接持たないため
  // createStateでStateを生成しState内のbuildメソッドを使う(らしい)
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   
  final String title = "Home Page";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(	 // 上に表示されてるバー
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[	 // ここの中に要素の配置？
            FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.of(context).pushNamed('/LIST');		// /Clickへ移動
              },
              child: Text('LIST VIEW'),		// ボタンのラベル
            ),

            FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.of(context).pushNamed('/MAP');		// /Clickへ移動
              },
              child: Text('MAP VIEW'),		// ボタンのラベル
            ),
          ],

        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}