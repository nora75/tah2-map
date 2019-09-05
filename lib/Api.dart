// APIをたたく


import 'dart:async';
import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: statefulApi(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,  // 戻る先自動設定?
            title: Text('API'),
            // 戻るボタン
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
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
    @required this.results,
  }) : super(key: key, child: child);
  final String results;

  static _MyInhertitedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_MyInhertitedWidget) as _MyInhertitedWidget;
  }

  // textが変更されたとき傘下のwidgetに更新を通知(指示)する
  @override
  bool updateShouldNotify(_MyInhertitedWidget old) => old.results != results;
}

class _ApiState extends State<statefulApi> {
  String results;

  void showText(data) {
    setState(() {
      print(data);
      results = data;
    });
  }

  static _ApiState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<_ApiState>());
  }

  @override
  Widget build(BuildContext context) {
    // _MyInhertitedWidgetのインスタンスの再生成
    return _MyInhertitedWidget(
      results: results,    // _ApiStateの持っているsの値を再生成するインスタンスに渡す
      child: widget.child,    // Apiが持っているツリーの再利用
    );

    
  }
}

class _SearchBar extends StatelessWidget{
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    double width = MediaQuery.of(context).size.width;   // 画面の横幅取得

    final _ApiState state = _ApiState.of(context);

    Future apiRequest(data) async {
      data = data.toString().replaceAll("　", " ");     // 全角スペースの削除
      String results = "";
      http.Response response = await http.get("https://script.google.com/macros/s/AKfycbxvArbjHqRgX1_lI0L2an9Nvkzv0n-Gfqyu95u0wmHkgB3AWueQ/exec?word=" + data);
      Map<String, dynamic> decoded = await json.decode(response.body);
      for(var result in decoded['results']){
        results += "名称 : ";
        results += result['name'];
        // results += "\n\t住所 : ";
        // results += result['formatted_address'];
        results += "\n";
      }
      state.showText(results);
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
          apiRequest(_controller.text);       
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

    String results = _MyInhertitedWidget.of(context).results;   
  
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,       
      children: <Widget>[
        Container(
          color: Colors.grey[300],
          width: width * 0.6,
          alignment: Alignment(0.0, 0.0),
          child: SingleChildScrollView(       // 長くなったらスクロール(できるとは言っていない)
            child: Text(
              "$results",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
              ),
            ),
          )
        )
    ],
  );
  }
}
