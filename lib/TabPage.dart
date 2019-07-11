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
                backgroundColor: Colors.blue[500],
                bottom: TabBar(
                  tabs: <Widget>[
                    /* タブ名&数設定 */
                    Tab(text: "Location"),
                    Tab(text: "History"),
                  ],
                )),
            body: TabBarView( // タブ
                children: <Widget>[
              Container(  // タブその1
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: new Stack(children: <Widget>[
                    Container(
                      child: _PrintText(width, height),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: height * 0.70),
                        child: _SearchBar(width, context))
                  ])),
              Container(  // タブその2
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
  final _controller = new TextEditingController(); // テキストの内容の取得や設定に使用するコントローラ

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: width * 0.7, // 横幅を画面の70%

        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2.0, // 線の太さ
            color: Colors.lightBlue[500],
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0) // かどまる君
              ),
        ),
        child: TextField(
            decoration: InputDecoration.collapsed(
                border: InputBorder.none, hintText: "検索したいキーワードを入力して下さい。"),
            inputFormatters: [
              LengthLimitingTextInputFormatter(100), // 文字数の入力制限(カウンターを表示しない)
            ],
            textAlign: TextAlign.center,
            controller: _controller,
            style: TextStyle(fontSize: 20.0, color: Colors.red)),
      ),
      ButtonTheme(
          child: FlatButton(
        color: Colors.lightBlue[500],
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: _controller.text?.isEmpty ?? true ? Text("入力しろ(# ･∀･)") : Text(_controller.text),
                  /* 入力せず検索した時 */
              );
            },
          );
        },
        child: Text("検索"),
      ))
    ],
  );
}

Widget _PrintText(width, height) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        color: Colors.blue[100],
        width: width, // 横幅全部
        height: height, // 縦幅65% 70%はスマホレイアウト狂う
        child: Text(
          "TEST",
          style: TextStyle(
            fontSize: 50,
            color: Colors.pink[300],
          ),
        ),
        alignment: Alignment(0.0, 0.0),
      )
    ],
  );
}
