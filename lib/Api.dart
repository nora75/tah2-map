import 'package:flutter/material.dart';

//  class Api extends StatefulWidget {
//    Api({Key key}) : super(key: key);
//
//    // StatefulWidgetはbuildメソッドを直接持たないため
//    // createStateでStateを生成しState内のbuildメソッドを使う(らしい)
//    @override
//    _Api createState() => _Api();
//  }
//
//  class _Api extends State<Api> {
//    @override
//    Widget build(BuildContext context) {
//    }
//

//Widget SearchBar(width, context, controller) {
//  return Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Container(
//        width: width * 0.7, // 横幅を画面の70%
//        decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border.all(
//            width: 2.0, // 線の太さ
//            color: Colors.lightBlue[500],
//          ),
//          borderRadius: BorderRadius.all(Radius.circular(5.0)), // かどまる君
//        ),
//
//        child: TextFormField(
//          textAlign: TextAlign.center,
//          controller: controller,
//          style: TextStyle(fontSize: 20.0, color: Colors.red),
//          onFieldSubmitted: (term) {
//          },
//          decoration: InputDecoration.collapsed(
//              border: InputBorder.none,
//              hintText: "キーワードまたは座標を入力"
//          ),
//        ),),
//      Container(
//          child: ButtonTheme(
//              child: FlatButton(
//                color: Colors.lightBlue[500],
//                onPressed: () {
//                  // setState(() {
//                  //   result.add(controller.text);
//                  // });
//                  // print(controller.text); // デバッグ用
//                  //hoge();
//                  //             return showDialog(
//                  //               context: context,
//                  //               builder: (context) {
//                  //                 return AlertDialog(
//                  //                   content: controller.text?.isEmpty ?? true
//                  //                       ? Text("入力しろ(# ･∀･)")
//                  //                       : Text(controller.text),
//                  // /* 入力せず検索した時 */
//                  //                 );
//                  //               },
//                  //             );
//                },
//                child: Text("検索"),
//              ))
//      )
//    ],
//  );
//}

Widget endDrawer() {
  return Scaffold(
      drawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[],
          )));
}

//}
