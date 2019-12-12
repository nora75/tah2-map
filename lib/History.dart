import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class History extends StatefulWidget {
//  final List<String> histList;
  final Stream<List<String>> histList;

  History({Key key, this.histList}) : super(key: key);

  @override
  _History createState() => _History();
}

class _History extends State<History> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width; // 画面の横幅取得
    double height = MediaQuery
        .of(context)
        .size
        .height; // 画面の縦幅取得

    return Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: Container(
          child: ShowHistoryList(width, height, context, widget.histList),
        )
    );
  }

// ignore: non_constant_identifier_names
  Widget ShowHistoryList(width, height, context, histList) {
    return StreamBuilder(
        stream: histList,
        builder: (BuildContext context, AsyncSnapshot<List<String>> list) {
          if (list.hasError) {
            return Text('Error: ${list.error}');
          }
          switch (list.connectionState) {
            // case ConnectionState.waiting:
            //   return const Text('起動中...');
            default:
              if (list.data == null) {
                return const Text('履歴画面');
              }
              return ListView(
                  padding: EdgeInsets.only(
                      top: height * 0.06,
                      left: width * 0.1,
                      right: width * 0.1
                  ),
                  children: list.data.map(((item) =>
                      Card( // リストの中身
                          child: InkWell( // タップイベントのため
                              onTap: () { // タップイベント
                                print('$item');
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[ // ここが表示内容
                                    Text('$item', style: TextStyle(
                                      fontSize: 40,
                                    )),
                                  ],
                                ),
                              )
                          )
                      ))).toList()
              );
          }
        }
    );
  }
}
