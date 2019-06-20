// タブのテスト

import 'dart:html';
import 'package:flutter_web/material.dart';

class TabPage extends StatelessWidget {
  TabPage({Key key}) : super(key: key);
  
  final String title = 'TabPage';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;   // 画面の横幅取得
    double height = MediaQuery.of(context).size.height;   // 画面の縦幅取得

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Porn Hub"),

          bottom: TabBar(
            tabs: <Widget>[   //タブ名
              Tab(text:"Location"),
              Tab(text:"History"),
            ],
          )
        ),

        body: TabBarView(   //タブ
          children: <Widget>[
            Container(    //タブ内容
              color: Colors.red,
              padding: EdgeInsets.only(top: 30.0),
              child: Column(   //横並び
                children: <Widget>[
                  _PrintText(width, height),
                  _SearchBar(width)
                ]
              ),
            ),
            
            Container(
              color: Colors.yellow,
              // child: Column(   //横並び
              //   children: <Widget>[
                  
              //   ]
              // )
            )
          ],
        ),
      )
    );
  }
}

Widget _SearchBar(width) {
  return Row(

  mainAxisAlignment: MainAxisAlignment.center,
        
  children: <Widget>[
    Container(
      width: width * 0.7,   // 横幅を画面の50%
      
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLength: 20,
      ),
      
    ),
    FlatButton(
      color: Colors.lightBlue[50],
      onPressed: () {
        // print("btn");
      },
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
        color: Colors.grey[300],
        width: width * 0.7,
        height: height * 0.6,
        child: Text(
          "TEST",
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

