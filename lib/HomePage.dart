// ホームページ
// 各ページをタブにて表示

import 'package:flutter/material.dart';

//import 'Api.dart';
import 'Filter.dart';
import 'History.dart';
import 'Secret.dart';
import 'SettingPage.dart';
import 'Tab.dart';

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
  List<Widget> myTabs;
  List<Widget> myTabsContents;
  List<String> inputList = [];
  final secret = new Secret(secretPath: "assets/key.json");

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
    textEditController = new TextEditingController();
    myTabs = <Widget>[
      MyTabIcon(inputList: inputList, secret: secret,),
      Tab(icon: Icon(Icons.history), text: "HISTORY"),
    ];
    myTabsContents = <Widget>[
      MyTabContents(inputList: inputList, secret: secret,),
      Tab(child: History(histList: inputList,)),
    ];
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
                _showInputListText(context, inputList.last);
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
                       _showInputListText(context, inputList.last);
                     });
                  },
                  child: Text("検索"),
                ))
        )
      ],
    );
  }
}

// 無駄に 'async' !
void _showInputListText(context, text) async => showDialog(
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
