import 'package:dailyroutines/constants/api_path.dart';
import 'package:dailyroutines/pages/home_page.dart';
import 'package:dailyroutines/pages/login_page.dart';
import 'package:dailyroutines/models/api_response.dart';
import 'package:dailyroutines/models/server_message.dart';
import 'package:dailyroutines/services/rest_api_service.dart';
import 'package:dailyroutines/services/session_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterApiDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<bool>(
      future: showLoginPage(),
      builder: (buildContext, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            // Return your login here
            return LoginPage();
          }
          // Return your home here
          return HomePage(username: 'testing');
        } else {
          // Return loading screen while reading preferences
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  Future<bool> showLoginPage() async {
    var sessionStorage = await SessionStorageService.getInstance();
    debugPrint(sessionStorage.checkSession().toString());
    return sessionStorage.checkSession();
  }
}
