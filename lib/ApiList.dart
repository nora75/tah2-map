import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Api.dart';

class ApiList extends StatelessWidget {
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
          Container(child: SearchBar(width, context))
        ])
    );
  }
}
