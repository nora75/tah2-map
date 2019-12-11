// ホームページ
// 各ページをタブにて表示

import 'dart:async';

import 'package:flutter/material.dart';

import 'Api.dart';
import 'Filter.dart';
import 'History.dart';
import 'Secret.dart';
import 'SettingPage.dart';
import 'Tab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final String title = "Home Page";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TabController tabController;
  List<Widget> myTabs;
  List<Widget> myTabsContents;
  final secret = new Secret(secretPath: "assets/key.json");
  final inputs = StreamController<List<String>>.broadcast();
  final results = StreamController<List<String>>.broadcast();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
    myTabs = <Widget>[
      MyTabIcon(inputList: inputs.stream, secret: secret,),
      Tab(icon: Icon(Icons.history), text: "HISTORY"),
    ];
    myTabsContents = <Widget>[
      MyTabContents(inputList: inputs.stream, result: results.stream, secret: secret,),
      Tab(child: History(histList: inputs.stream,)),
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    results.close();
    inputs.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return new Scaffold(
      appBar: AppBar(
        title: Text("Tah2-Map"),
        backgroundColor: Colors.blue[500],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingPage()
                  ));
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: myTabs,
        ),
      ),
      drawer: Filter(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: myTabsContents,
              ),
            ),
            Container(child: Api(sink: inputs.sink, resultSink: results.sink, secret: secret)),
          ]),
    );
  }
}

