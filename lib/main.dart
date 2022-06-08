import 'package:dailyroutines/flutter_api_demo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: "DEV",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: {
      "baseApiUrl": "http://192.168.0.36:10004",
      "baseKeycloakUrl": "http://192.168.0.36:10002",
    },
  );
  runApp(FlutterApiDemoApp());
}
