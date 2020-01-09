import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Secret.dart';

class ApiList extends StatelessWidget {
  Stream<List<String>> inputList;
  final Secret secret;

  ApiList({Key key, this.inputList, this.secret,}) : super(key: key);

// TODO リスト画面の作成
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    final String listKey = secret.listKey;

    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      // 下記のStreamBuilderなるものを使用する事で、入力値の取得が可能になってます。
      // streamは変更しないで下さい。
      child: StreamBuilder (
        stream: this.inputList,
        // ここの中にあるColumnの所を変えて下さい。
        // 要はreturnで動的なWidget返せばいい
        // 入力された内容が inpuList にて 配列(List<String>)で取得出来ます。
        // 使用例 inputList.last : 最後の値を取得する。
        builder: (BuildContext context, AsyncSnapshot<List> inputList) {
          // エラー処理らしい
          if (inputList.hasError) {
            return Text('Error: ${inputList.error}');
          }
          switch (inputList.connectionState) {
          // ロード待ちの時らしいんだけどまあないと思う。
            // case ConnectionState.waiting:
            //   return const Text('ロード中....');
            default:
            // まだ何も検索されてない時はここ(初期状態及び起動後)
              if (inputList.data == null) {
                return const Text('検索して下さい');
              }
              // 検索された時の処理はここ
              print(inputList.data.last);
              return FutureBuilder(
                future: _apiRequest(inputList.data.last, listKey),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Text('検索中');
                  }
                  print(snapshot);
                  return PrintText(width, height, snapshot, context);
                },
              );
          }
        }
      )
    );
  }
}

Widget PrintText(width, height, inputList, context) {

  return SizedBox(
    height: height,
    width: width,
    child: ListView.builder(
      padding: EdgeInsets.only(
        top: height * 0.06, left: width * 0.1, right: width * 0.1),
      itemBuilder: (BuildContext context, int index) {
        return Card(
        // リストの中身
          child: InkWell(
            // タップイベントのため
            onTap: () {
              // タップイベント
              print(index);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  // ここが表示内容
                  Text(
                    inputList.data[index],
                    style: TextStyle(
                      fontSize: 40,
                    )
                  ),
                ],
              ),
            )
          )
        );
      },
      itemCount: inputList.data.length, // データ件数
    )
  );
}

Future _apiRequest(text, listKey) async {
  List<String> results = [];
  http.Response response = await http.get("https://maps.googleapis.com/maps/api/place/textsearch/json?language=ja&key=" + listKey + "&query=" + text);
  Map<String, dynamic> decoded = await json.decode(response.body);
  for(var result in decoded['results']){
    results.add(result['name']);
  }
  return results;
}