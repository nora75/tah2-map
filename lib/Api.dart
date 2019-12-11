import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'Secret.dart';

class Api extends StatefulWidget {
  final StreamSink<List<String>> sink;
  final StreamSink<List<String>> resultSink;
  final Secret secret;

  Api({Key key, this.sink, this.resultSink, this.secret}) : super(key: key);

  @override
  _Api createState() => _Api();
}

class _Api extends State<Api> {
  TextEditingController controller = new TextEditingController();
  List<String> inputList = [];
  List<String> result = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return SearchBar(width, context);
  }

// ignore: non_constant_identifier_names
  Widget SearchBar(width, context) {

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
            borderRadius: BorderRadius.all(Radius.circular(5.0)), // かどまる君
          ),

          child: TextFormField(
            textAlign: TextAlign.center,
            controller: controller,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
            onFieldSubmitted: (term) {
              _toSink(widget.sink, inputList, controller.text, context);
              _apiRequest(widget.resultSink, controller.text, widget.secret);
            },
            decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: "キーワードまたは座標を入力"
            ),
          ),),
        Container(
            child: ButtonTheme(
                child: FlatButton(
                  color: Colors.lightBlue[500],
                  onPressed: () {
                    _toSink(widget.sink, inputList, controller.text, context);
                    _apiRequest(widget.resultSink, controller.text, widget.secret);
                  },
                  child: Text("検索"),
                ))
        )
      ],
    );
  }
}

// 無駄に 'async' !
void _showInputListText(context, text) async =>
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: text?.isEmpty ?? true
              ? Text("入力しろ(# ･∀･)")
              : Text(text),
          /* 入力せず検索した時 */
        );
      },
    );

void _toSink(sink, inputList, text, context) {
  inputList.add(text);
  sink.add(inputList);
  _showInputListText(context, text);
}

void _showResult(sink, result, text) {
  result.add(text);
  sink.add(result);
}

void _apiRequest(sink, text, secret) async {
  String listKey = secret.listKey;
  List<String> results = [];
  http.Response response = await http.get("https://maps.googleapis.com/maps/api/place/textsearch/json?language=ja&key=" + listKey + "&query=" + text);
  Map<String, dynamic> decoded = await json.decode(response.body);
  for(var result in decoded['results']){
    results.add(result['name']);
  }
  sink.add(results);
}