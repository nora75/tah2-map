// APIをたたく


import 'dart:async';
import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: statefulApi(
        child: Scaffold(
          appBar: AppBar(
            title: Text('API'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _SearchBar(),
              _PrintText(),
            ],
          ),
        ),
      ),
    );
  }
}

class statefulApi extends StatefulWidget {
  statefulApi({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  State createState() => _ApiState();
}

class _MyInhertitedWidget extends InheritedWidget {
  const _MyInhertitedWidget({
    Key key,
    @required Widget child,
    @required this.text,
  }) : super(key: key, child: child);
  final String text;

  static _MyInhertitedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_MyInhertitedWidget) as _MyInhertitedWidget;
  }

  // textが変更されたとき傘下のwidgetに更新を通知(指示)する
  @override
  bool updateShouldNotify(_MyInhertitedWidget old) => old.text != text;
}

class _ApiState extends State<statefulApi> {
  String s = "";

  void showText(text) {
    setState(() {
      s = text;
    });
  }

  static _ApiState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<_ApiState>());
  }

  @override
  Widget build(BuildContext context) {
    // _MyInhertitedWidgetのインスタンスの再生成
    return _MyInhertitedWidget(
      text: s,    // _ApiStateの持っているsの値を再生成するインスタンスに渡す
      child: widget.child,    // Apiが持っているツリーの再利用
    );

    
  }
}

class _SearchBar extends StatelessWidget{
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    double width = MediaQuery.of(context).size.width;   // 画面の横幅取得

    final _ApiState state = _ApiState.of(context);

    Future<String> apiRequest() async {
      return await _getData().toString();
    }

    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: width * 0.5,   // 横幅を画面の50%
        
        child: TextFormField(
          controller: _controller,
          textAlign: TextAlign.center,
          maxLength: 20,
        ),
        
      ),
      FlatButton(
        color: Colors.lightBlue[50],
        onPressed: () {
          // print("btn");
          // String data = apiRequest().toString();
          state.showText(_controller.text);
          
        },
        child: Text("検索"),
      )
    ],
  );
  }
}

class _PrintText extends StatelessWidget{
  Widget build (BuildContext context) {
    double width = MediaQuery.of(context).size.width;   // 画面の横幅取得
    double height = MediaQuery.of(context).size.height;   // 画面の縦幅取得

    final String s = _MyInhertitedWidget.of(context).text;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,       
      children: <Widget>[
        Container(
          color: Colors.grey[300],
          width: width * 0.6,
          height: height * 0.7,
          child: Text(
            "$s",
            style: TextStyle(
              fontSize: 50,
              color: Colors.grey[800],
            ),
          ),
          alignment: Alignment(0.0, 0.0),
        )
    ],
  );
  }
}

Future<Map<String, dynamic>> _getData() async {
  http.Response response = await http.get("https://script.google.com/macros/s/AKfycbw_j6bWqumY1wkBVg05mGTJHj_C9CZuhfJhrvRVf3PUZ4bF6R0t/exec?data=");
  Map<String, dynamic> decoded = json.decode(response.body);
  return decoded;
}