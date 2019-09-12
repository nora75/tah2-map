import 'dart:html';
import 'package:flutter_web/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class tah2 extends StatefulWidget {
  tah2() : super();

  @override
  _tah2State createState() => _tah2State();
}

class _tah2State extends State<tah2> {
  List<String> s = ["a", "b"];
  final _controller = TextEditingController(); // テキストの内容の取得や設定に使用するコントローラ
  bool konbini = false;

  Future apiRequest(data) async {
    if (konbini) {
      data = data + " コンビニ";
    }
    data = data.toString().replaceAll("　", " "); // 全角スペースの削除
    // String results = "";
    // http.Response response = await http.get("https://script.google.com/macros/s/AKfycbxvArbjHqRgX1_lI0L2an9Nvkzv0n-Gfqyu95u0wmHkgB3AWueQ/exec?word=" + data);
    // Map<String, dynamic> decoded = await json.decode(response.body);
    // for(var result in decoded['results']){
    //   results += "名称 : ";
    //   results += result['name'];
    //   // results += "\n\t住所 : ";
    //   // results += result['formatted_address'];
    //   results += "\n";
    // }

    List<String> results = [];
    s.clear();
    http.Response response = await http.get(
        "https://script.google.com/macros/s/AKfycbxvArbjHqRgX1_lI0L2an9Nvkzv0n-Gfqyu95u0wmHkgB3AWueQ/exec?word=" +
            data);
    Map<String, dynamic> decoded = await json.decode(response.body);
    for (var result in decoded['results']) {
      results.add(result['name']);
      print(result['name']);
    }
    setState(() {
      s = results;
    });
  }

  final String title = "tah2";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return Scaffold(
      appBar: AppBar(
        title: Text("Tah2-Map"),
        backgroundColor: Colors.blue[500],
      ),
      body: Container(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Stack(children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: height * 0.80),
                child: _Filtering()),
            Container(
              child: _PrintText(width, height),
            ),
            Container(
                padding: EdgeInsets.only(top: height * 0.01),
                child: _SearchBar(width, context))
          ])),
    );
  }

  Widget _PrintText(width, height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            //color: Colors.blue[100],
            // width: width, // 横幅全部
            // height: height, // 縦幅65% 70%はスマホレイアウト狂う
            // child:
            // Text(
            //   "TEST",
            //   style: TextStyle(
            //     fontSize: 50,
            //     color: Colors.pink[300],
            //   ),
            // ),
            //alignment: Alignment(0.0, 0.0),
            )
      ],
    );
  }

  Widget _SearchBar(width, context) {
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
                border: InputBorder.none,
                hintText: "キーワードまたは座標を入力",
              ),
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
            if (_controller.text.isEmpty) {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text('文字を入力してください'));
                },
              );
            } else {
              apiRequest(_controller.text);
              // apiRequest('蒲田');
            }
          },
          child: Text("検索"),
        ))
      ],
    );
  }

  Widget _Filtering() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          child: Text("コンビニ"),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {},
        ),
      ),
      Container(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          child: Text("スーパー"),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {},
        ),
      ),
      Container(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          child: Text("ドラッグストア"),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {},
        ),
      )
    ]);
  }
}
