import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Api.dart';

class ApiList extends StatefulWidget {
  ApiList({Key key}): super(key: key);

  @override
  _ApiList createState() => _ApiList();
}

class _ApiList extends State<ApiList> {
  final _controller = TextEditingController(); // テキストの内容の取得や設定に使用するコントローラ

  var result = [];    // 検索結果

  // var n = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Stack(children: <Widget>[
        Container(
          child: PrintText(width, height, context),
        ),
        Container(
          child: SearchBar(width, context)
        ),
        // Container(
        // child: Text(n.toString()),
        // ),
        // Container(
        //   margin: EdgeInsets.only(top: 50),
        //   child: RaisedButton(
        //     child: Text("btn"),
        //     color: Colors.red,
        //     onPressed: (){
        //       setState((){
        //         n = n + 1;
        //         print("$n");
        //       }
        //       );
        //     },
        //   )
        // ),
      ])
    );
  }
}
