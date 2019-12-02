// ホームページ
// 各ページへのリンク

import 'package:flutter/material.dart';
import 'ApiList.dart';
import 'ApiMap.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // StatefulWidgetはbuildメソッドを直接持たないため
  // createStateでStateを生成しState内のbuildメソッドを使う(らしい)
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final String title = "Home Page";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Test App"),
        backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: new Material(
        color: Colors.teal,
        child: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.list), text: "LIST"),
            new Tab(icon: new Icon(Icons.map), text: "MAP"),
          ],
        ),
      ),
      body: new TabBarView(controller: controller, children: <Widget>[
        new ApiList(),
        new ApiMap(),
      ]),
    );
  }
}
