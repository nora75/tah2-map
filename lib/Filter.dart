import 'package:flutter/material.dart';

//TODO フィルターの処理を書く
class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
