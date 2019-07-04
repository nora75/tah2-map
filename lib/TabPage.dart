// タブのテスト

import 'dart:html';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

class TabPage extends StatelessWidget {
  TabPage({Key key}) : super(key: key);

  final String title = 'TabPage';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text("Tah2-Map"),
                backgroundColor: Colors.pink[300],
                bottom: TabBar(
                  tabs: <Widget>[
                    //タブ名&数設定
                    Tab(text: "Location"),
                    Tab(text: "History"),
                  ],
                )),
            body: TabBarView(//タブ
                children: <Widget>[
              Container(
                  //タブその1
//color: Colors.red,
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: new Stack(children: <Widget>[
                    Container(
                      child: _PrintText(width, height),
                    ),

                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.only(top: height * 0.70),
                      child: _SearchBar(width, context)
                    )
                  ])),
              Container(
                //タブその2
                color: Colors.red,
// child: Column(
//   children: <Widget>[

//   ]
// )
              )
            ])));
  }
}

Widget _SearchBar(width, context) {
// テキストの内容の取得や設定に使用するコントローラ
  final _controller = new TextEditingController();
// テキストの装飾に使用する
  final _decorator = new InputDecoration(labelText: "検索したいキーワードを入力して下さい。");

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: width * 0.7, // 横幅を画面の70%

        child: TextFormField(
          textAlign: TextAlign.center,
          controller: _controller,
          decoration: _decorator,
          maxLength: 20,
        ),
      ),
      FlatButton(
        color: Colors.lightBlue[50],
        onPressed: () {},
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
        width: width, //横幅全部
        height: height, //縦幅65% 70%はスマホレイアウト狂う
        child: Text(
          "TEST",
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
        alignment: Alignment(0.0, 0.0),
      )
    ],
  );
}
