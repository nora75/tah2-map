import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Secret.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show CameraPosition, GoogleMap, GoogleMapController, LatLng;
import 'package:location/location.dart' show Location, LocationData;
import 'package:flutter/services.dart';

class ApiMap extends StatefulWidget {
  final Stream<List<String>> inputList;
  final Secret secret;

  ApiMap({Key key, this.inputList, this.secret}) : super(key: key);

  @override
  _ApiMap createState() => _ApiMap();
}

class _ApiMap extends State<ApiMap>{
//  LocationData currentLocation;
  GoogleMapController mapController;

  Location _locationService = new Location();
  String error;
  final currentLocation = StreamController<LocationData>();

  State<StatefulWidget> createState() {
    initPlatformState();
    _locationService.onLocationChanged().listen((LocationData result) async {
      currentLocation.sink.add(result);
    });
    return null;
  }

  @override
  void dispose() {
    currentLocation.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    return Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
        // 下記のStreamBuilderなるものを使用する事で、入力値の取得が可能になってます。
        // streamは変更しないで下さい。
        child: StreamBuilder(
            stream: widget.inputList,
            // ここの中にあるColumnの所を変えて下さい。
            // 要はreturnで動的なWidget返せばいい
            // 入力された内容が inpuList にて 配列(List<String>)で取得出来ます。
            // 使用例 inputList.last : 最後の値を取得する。
            builder: (BuildContext context, AsyncSnapshot<List> inputList) {
              // エラー処理らしい
              if (inputList.hasError) {
                return CircularProgressIndicator();
              }

              switch (inputList.connectionState) {
              // ロード待ちの時らしいんだけどまあないと思う。
              // case ConnectionState.waiting:
              //   return const Text('ロード中....');
                default:
                // まだ何も検索されてない時はここ(初期状態及び起動後)
                  if (inputList.data == null) {
                    return CircularProgressIndicator();
                  }
                  // 検索された時の処理はここ
                  return StreamBuilder(
                      stream: currentLocation.stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<LocationData> currentLocation) {
                        if (currentLocation.data == null) {
                          return CircularProgressIndicator();
                        } else {
                          return GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(currentLocation.data.latitude,
                                  currentLocation.data.longitude), zoom: 17.0,),
                            myLocationEnabled: true,
                          );
                        }
                      }
                  );
              }
            }
        )
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void initPlatformState() async {
    LocationData myLocation;
    try {
      myLocation = await _locationService.getLocation();
      error = "";
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENITED')
        error = 'Permission denited';
      else if (e.code == 'PERMISSION_DENITED_NEVER_ASK')
        error =
        'Permission denited - please ask the user to enable it from the app settings';
      myLocation = null;
    }
    currentLocation.sink.add(myLocation);
  }
}
