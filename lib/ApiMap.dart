import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Secret.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show CameraPosition, GoogleMap, GoogleMapController, LatLng;
import 'package:location/location.dart' show Location, LocationData;
import 'package:flutter/services.dart';

class ApiMap extends StatefulWidget {
final List<String> inputList;
final Secret secret;
ApiMap({Key key, this.inputList, this.secret}) : super(key: key);

@override
  State createState() => ApiState();
}

class ApiState extends State<ApiMap> {
  LocationData currentLocation;
  GoogleMapController mapController;

  Location _locationService = new Location();
  String error;

  @override
  void initState() {
    super.initState();

    initPlatformState();
    _locationService.onLocationChanged().listen((LocationData result) async {
      setState(() {
        currentLocation = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // 画面の横幅取得
    double height = MediaQuery.of(context).size.height; // 画面の縦幅取得

    if (currentLocation == null) {
      // 追加
      return Center(
        // 追加
        child: CircularProgressIndicator(), // 追加
      ); // 追加
    } else {
      // 追加
      return Container(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Stack(children: <Widget>[
            Container(
              width: width,
              height: height,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  // 最初のカメラ位置
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 17.0,
                ),
              ),
            ),
          ]));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
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
    setState(() {
      currentLocation = myLocation;
    });
  }
}
