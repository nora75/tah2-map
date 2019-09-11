// メイン

import 'package:flutter_web/material.dart';
import 'package:tah2_map/tah2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
	return MaterialApp(
		// title: 'Flutter Demo',
		theme: ThemeData(
		primarySwatch: Colors.blue,	 // appbar等の色
		),
		debugShowCheckedModeBanner: false,	// こいつで右上のDebug表示を消せる
		routes: <String, WidgetBuilder> {
		  '/' : (_) => tah2(),
		}
	);
	}
}