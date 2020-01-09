import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

import 'ApiList.dart';
import 'ViewMap.dart';

// ignore: must_be_immutable
class MyTabIcon extends StatelessWidget{
  final List<String> inputList;
  final secret;

  MyTabIcon({Key key, this.inputList, this.secret}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Settings().onStringChanged(
      settingKey: 'ViewSetting',
      defaultValue: 'LIST',
      childBuilder: (BuildContext context, String value){
        if (value == 'LIST') {
          return Tab(icon: Icon(Icons.list), text: "LIST");
        } else {
          return Tab( icon: Icon(Icons.map), text: "MAP");
        }},
    );

  }
}

// ignore: must_be_immutable
class MyTabContents extends StatelessWidget{
  final List<String> inputList;
  final secret;

  MyTabContents({Key key, this.inputList, this.secret}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Settings().onStringChanged(
      settingKey: 'ViewSetting',
      defaultValue: 'LIST',
      childBuilder: (BuildContext context, String value){
        if (value == 'LIST') {
          return Tab(child:ApiList(inputList: inputList, secret: secret,));
        } else {
          return Tab(child: ViewMap(inputList: inputList, secret: secret,));
        }},
    );

  }
}
