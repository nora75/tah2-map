import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Secret {
  final String secretPath;
  static String list = "list_api_key";
  static String map = "map_api_key";
  String listKey;
  String mapKey;

  Secret({this.secretPath}){
    this.load();
  }

  load() {
    return rootBundle.loadStructuredData(this.secretPath,
            (jsonStr) async {
              Map<String, dynamic> jsonMap = json.decode(jsonStr);
              this.listKey = jsonMap[list];
              this.mapKey = jsonMap[map];
              return;
        });
  }

}
