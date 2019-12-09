// メイン

import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(Tah2());

class Tah2 extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
	return MaterialApp(
		// title: 'Flutter Demo',
		theme: ThemeData(
      primarySwatch: Colors.blue,	 // appbar等の色
		),
		debugShowCheckedModeBanner: false,	// こいつで右上のDebug表示を消せる
		home: HomePage(),
	);
	}
}