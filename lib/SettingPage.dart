import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Application Settings",
      children: [
        RadioSettingsTile(
          settingKey: 'ViewSetting',
          title: '検索結果の表示方式を選択して下さい。',
          defaultKey: "LIST",
          values: {
            'LIST': 'リストビューを使用する',
            'MAP': 'マップビューを使用する',
          },
        ),
      ],
    );
  }

}
