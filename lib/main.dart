import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(Tah2());

class Tah2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tah2Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'The Map'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPage createState() => _MainPage();
}


class _MainPage extends State{
    final _controller = TextEditingController(); // テキストの内容の取得や設定に使用するコントローラ

  var result = [];    // 検索結果

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return Scaffold(
      appBar: AppBar(
        title: Text("Tah2-Map"),
        backgroundColor: Colors.blue[500],
      ),
      body: Container(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Stack(children: <Widget>[
            Container(
              child: _PrintText(width, height, context),
            ),
            Container(
                child: _SearchBar(width, context))
          ])),
      drawer: Drawer(
        elevation: 20.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('フィルタリング'),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              title: Text('コンビニ'),
              onTap: () {},
            ),
            ListTile(
              title: Text('スーパー'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
  Widget _SearchBar(width, context) {

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

          child: TextField(
            decoration: InputDecoration.collapsed(
              border: InputBorder.none, hintText: "キーワードまたは座標を入力"
            ),
//              inputFormatters: [
//                LengthLimitingTextInputFormatter(100), // 文字数の入力制限(カウンターを表示しない)
//              ],
            textAlign: TextAlign.center,
            controller: _controller,
            style: TextStyle(fontSize: 20.0, color: Colors.red)
          ),
        ),
        ButtonTheme(
          child: FlatButton(
            color: Colors.lightBlue[500],
            onPressed: () {
              // setState(() {
              //   result.add(_controller.text);
              // });
              // print(_controller.text); // デバッグ用
              //hoge();
              //             return showDialog(
              //               context: context,
              //               builder: (context) {
              //                 return AlertDialog(
              //                   content: _controller.text?.isEmpty ?? true
              //                       ? Text("入力しろ(# ･∀･)")
              //                       : Text(_controller.text),
              // /* 入力せず検索した時 */
              //                 );
              //               },
              //             );
            },
            child: Text("検索"),
          )
        )
      ],
    );
  }
  Widget _PrintText(width, height, context) {
    return ListView.builder(  
      padding: EdgeInsets.only(
        top: height * 0.06,
        left: width * 0.1,
        right: width * 0.1
      ),
      itemBuilder: (BuildContext context, int index){
        return Card(    // リストの中身
          child: InkWell(   // タップイベントのため
            onTap: (){      // タップイベント
              print(index);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[     // ここが表示内容
                  Text(result[index], style: TextStyle(
                    fontSize: 40,
                  )),
                ],
              ),
            )
          )
        );
      },
      itemCount: result.length,   // データ件数
    );
  }

  Widget endDrawer() {
    return Scaffold(
        drawer: Drawer(
            elevation: 20.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[],
            )));
  }
}