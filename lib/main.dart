import 'dart:html';

import 'package:flutter_web/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),   // MyHomePageの呼び出し
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // StatefulWidgetはbuildメソッドを直接持たないため
  // createStateでStateを生成しState内のbuildメソッドを使う(らしい)
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   

  final String title = "demo";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  int _i = 0;     // カウント用変数

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
            Text (
              "$_i",
            ),
            // ボタンの設置
            FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.lightBlue,
              onPressed: () {
                setState(() => _i++);   // 状態を反映させるにはsetStateを呼び出す必要があるらしい(対象など要検証)
                print('$_i');   // コンソール側に表示
                // _i++;
              },
              child: Text('Button'),    // ボタンのラベル
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
