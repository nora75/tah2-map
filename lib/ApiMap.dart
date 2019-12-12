import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Secret.dart';

class ApiMap extends StatelessWidget {
  final Stream<List<String>> inputList;
  final Secret secret;

  const ApiMap({Key key, this.inputList, this.secret}) : super(key: key);

// TODO マップ画面の作成
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: StreamBuilder(
            stream: this.inputList,
            builder: (BuildContext context, AsyncSnapshot<List> inputList) {
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
                  return Column(
                    children: <Widget>[],
                  );
              }
            }));
  }
}
