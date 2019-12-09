import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class History extends StatelessWidget {
  final List<String> histList;
  const History({Key key, this.histList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

      return Container(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            child: ShowHistoryList(width, height, context, histList),
          )
      );
  }
}

Widget ShowHistoryList(width, height, context, histList) {
  return MaterialApp(
    title: 'ひすとりぃ',
    home: Scaffold(
      body: const Center(
        child: const Text('ひすとりぃ'),
      ),
    ),
    debugShowCheckedModeBanner: false,	// こいつで右上のDebug表示を消せる
  );
}
