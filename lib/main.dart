import 'dart:html';

import 'package:flutter_web/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,   // appbar等の色
      ),
      debugShowCheckedModeBanner: false,  // こいつで右上のDebug表示を消せる
      routes: <String, WidgetBuilder> {
        '/' : (_) => new HomePage(),
        '/Click' : (_) => Click(),
      }
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // StatefulWidgetはbuildメソッドを直接持たないため
  // createStateでStateを生成しState内のbuildメソッドを使う(らしい)
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   
  final String title = "Home";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   // 上に表示されてるバー
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[   // ここの中に要素の配置？

            FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.of(context).pushNamed('/Click');    // /Clickへ移動
              },
              child: Text('Click'),    // ボタンのラベル
            )

            
          ],
          
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class Click extends StatefulWidget {
  Click({Key key}) : super(key: key);

  @override
  _ClickState createState() => _ClickState();
}

class _ClickState extends State<Click> {
   
  final String title = "Click";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  int _cnt = 0;     // カウント用変数

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
              "$_cnt",
            ),
            // ボタンの設置
            FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.lightBlue,
              onPressed: () {
                setState(() => _cnt++);   // 状態を反映させるにはsetStateを呼び出す必要があるらしい(対象など要検証)
                print('$_cnt');   // コンソール側に表示
                // _cnt++;
              },
              child: Text('Count'),    // ボタンのラベル
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
