// ホームページ
// 各ページをタブにて表示

import 'package:flutter/material.dart';
import 'Api.dart';
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
  final String title = "Home Page";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TabController tabController;
  TextEditingController textEditController;
  bool mapListSwitch = true;
  List<Tab> myTabs;
  List<Tab> myTabsContents;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
    textEditController = new TextEditingController();
  }

  @override
  void dispose() {
    tabController.dispose();
    textEditController.dispose();
    super.dispose();
  }

  //TODO 全体的にレイアウトの見直し、サイズをいい感じにする
  //TODO インプットの引き渡し
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得
    myTabs = <Tab>[
      mapListSwitch ?? true
          ? Tab(icon: Icon(Icons.list), text: "LIST")
          : Tab(
              icon: Icon(Icons.map),
              text: "MAP",
            ),
      Tab(icon: Icon(Icons.history), text: "HISTORY"),
    ];
    myTabsContents = <Tab>[
      Tab(child: mapListSwitch ?? true ? ApiList() : ApiMap()),
      Tab(child: History()),
    ];

    return new Scaffold(
      appBar: AppBar(
        title: Text("Tah2-Map"),
        backgroundColor: Colors.blue[500],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => setState(() {
              mapListSwitch = true;
            }),
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => setState(() {
              mapListSwitch = false;
            }),
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
            Container(child: SearchBar(width, context, textEditController)),
          ]),
    );
  }
}

ShowInputText(context, controller) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: controller.text?.isEmpty ?? true
            ? Text("入力しろ(# ･∀･)")
            : Text(controller.text),
        /* 入力せず検索した時 */
      );
    },
  );
}
