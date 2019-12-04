import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApiMap extends StatelessWidget {

// TODO マップ画面の作成
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Text("Map"),
    );
  }
}
