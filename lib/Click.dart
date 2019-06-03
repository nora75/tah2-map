// ボタンのテスト

import 'dart:html';
import 'package:flutter_web/material.dart';

class Click extends StatefulWidget {
  Click({Key key}) : super(key: key);

  @override
  _ClickState createState() => _ClickState();
}

class _ClickState extends State<Click> {
   
  final String title = "Click";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  int _cnt = 0;		 // カウント用変数

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      // appbar : 上にあるバー
      appBar: AppBar(
        title: Text(title),
      ),

      //フローティングボタン
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,   // 下に配置
        children: <Widget>[
          FloatingActionButton(
              child: Text("フローティング"),
              foregroundColor: Colors.black,  // 文字色
              onPressed: () {
                setState(() => _cnt += 10);
              },
            )
        ],),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 画面に変数の中身表示
            Text (
              "$_cnt",
            ),
            // フラットボタンの設置
            FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.lightBlue,
              onPressed: () {
                setState(() => _cnt++);	 // 状態を反映させるにはsetStateを呼び出す必要があるらしい(対象など要検証)
                print('$_cnt');	 // コンソール側に表示
                // _cnt++;
              },
              child: Text('フラットボタン'),		// ボタンのラベル
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
