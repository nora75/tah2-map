// ホームページ
// 各ページをタブにて表示

import 'package:flutter/material.dart';
//import 'Api.dart';
import 'ApiList.dart';
import 'ApiMap.dart';
import 'Filter.dart';
import 'History.dart';
import 'Secret.dart';

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
  List<String> inputList = [];
  final secret = new Secret(secretPath: "key.json");

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得
    // mapListSwitchの値を基にタブの内容の変更
    myTabs = <Tab>[
      mapListSwitch ?? true
          ? Tab(icon: Icon(Icons.list), text: "LIST")
          : Tab( icon: Icon(Icons.map), text: "MAP"),
      Tab(icon: Icon(Icons.history), text: "HISTORY"),
    ];
    // mapListSwitchの値を基にタブの内容の変更
    myTabsContents = <Tab>[
      Tab(child: mapListSwitch ?? true
          ? ApiList(inputList: inputList, secret: secret,)
          : ApiMap(inputList: inputList, secret: secret,)),
      Tab(child: History(histList: inputList,)),
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

  // ignore: non_constant_identifier_names
  Widget SearchBar(width, context, controller) {
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
              setState(() {
                inputList.add(controller.text);
                ShowinputListText(context, inputList.last);
              });
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
                     setState(() {
                       inputList.add(controller.text);
                       ShowinputListText(context, inputList.last);
                     });
                    // print(controller.text); // デバッグ用
                    //hoge();
                    //             return showDialog(
                    //               context: context,
                    //               builder: (context) {
                    //                 return AlertDialog(
                    //                   content: controller.text?.isEmpty ?? true
                    //                       ? Text("入力しろ(# ･∀･)")
                    //                       : Text(controller.text),
                    // /* 入力せず検索した時 */
                    //                 );
                    //               },
                    //             );
                  },
                  child: Text("検索"),
                ))
        )
      ],
    );
  }
}

// ignore: non_constant_identifier_names
ShowinputListText(context, text) {
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
}
