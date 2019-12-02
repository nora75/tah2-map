import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApiList extends StatelessWidget {
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
            Container(child: _SearchBar(width, context))
          ])),
      drawer: Drawer(
        elevation: 20.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('フィルタリング'),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              title: Text('コンビニ'),
              onTap: () {},
            ),
            ListTile(
              title: Text('ATM'),
              onTap: () {},
            ),
            ListTile(
              title: Text('スーパー'),
              onTap: () {},
            ),
            ListTile(
              title: Text('レストラン'),
              onTap: () {},
            ),
            ListTile(
              title: Text('居酒屋'),
              onTap: () {},
            ),
            ListTile(
              title: Text('病院'),
              onTap: () {},
            ),
            ListTile(
              title: Text('薬局'),
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

          child: TextFormField(
            textAlign: TextAlign.center,
            controller: _controller,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
            onFieldSubmitted: (term){
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: _controller.text?.isEmpty ?? true
                        ? Text("入力しろ(# ･∀･)")
                        : Text(_controller.text),
                    /* 入力せず検索した時 */
                  );
                },
              );
            },
            decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: "キーワードまたは座標を入力"
            ),
          ),),
        Container(
            child:ButtonTheme(
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
                ))
        )],
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
