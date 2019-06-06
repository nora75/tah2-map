// メイン

import 'package:flutter_web/material.dart';
import 'package:tah2_map/Click.dart';
import 'package:tah2_map/HomePage.dart';
import 'package:tah2_map/TextF.dart';
import 'package:tah2_map/TabPage.dart';
import 'package:tah2_map/Api.dart';

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
		'/' : (_) => HomePage(),
		'/Click' : (_) => Click(),
    '/TextF' : (_) => TextF(),
    '/TabPage' : (_) => TabPage(),
    '/Api' : (_) => Api(),
		}
	);
	}
}