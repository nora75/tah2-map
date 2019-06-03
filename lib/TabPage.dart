// タブのテスト

import 'dart:html';
import 'package:flutter_web/material.dart';

class TabPage extends StatelessWidget {
  TabPage({Key key}) : super(key: key);
  
  final String title = 'TabPage';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),

          bottom: TabBar(
            tabs: <Widget>[
              Tab(text:"Location"),
              Tab(text:"History"),
            ],
          )
        ),

        body: TabBarView(
          children: <Widget>[
            Container(
              color: Colors.red,
              /*child: Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Location"),
                    onPressed: (){}
                  ),

                  TextField(
                    decoration: InputDecoration(
                      hintText: "Address"
                    ),
                  ),

                  Text(
                    "This is text"
                  ),

                  RaisedButton(
                    child: Text("Search"),
                    onPressed: () {}
                  ),
                ]
              ),*/
            ),
            
            Container(
              color: Colors.yellow,
            )
          ],
        ),
      )
    );
  }
}

