// ホームページ
// 各ページへのリンク

import 'package:flutter/material.dart';
import 'ApiList.dart';
import 'ApiMap.dart';
import 'Filter.dart';
import 'History.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // StatefulWidgetはbuildメソッドを直接持たないため
  // createStateでStateを生成しState内のbuildメソッドを使う(らしい)
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(icon: Icon(Icons.list), text: "LIST"),
    Tab(icon: Icon(Icons.map), text: "MAP",),
    Tab(icon: Icon(Icons.history), text: "HISTORY"),
  ];
  final List<Widget> myTabsContents = <Widget> [
    ApiList(),
    ApiMap(),
    History(),
  ];
  final String title = "Home Page";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //TODO テキストフィールドと検索ボタンを最下部に配置する
  //TODO 全体的にレイアウトの見直し、サイズをいい感じにする
  //TODO インプットの引き渡し
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text("Tah2-Map"),
        backgroundColor: Colors.blue[500],
        bottom: TabBar(
            controller: controller,
            tabs: myTabs
        ),
      ),
      drawer: Filter(),
      body: Column(
        children: <Widget> [
          Expanded(
            child: TabBarView(controller: controller, children: <Widget> [
              ApiList(),
              ApiMap(),
              History(),
            ]
            ),
          ),
      ]),
    );
  }
}
