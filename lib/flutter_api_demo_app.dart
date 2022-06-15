import 'package:dailyroutines/pages/home_page.dart';
import 'package:dailyroutines/pages/login_page.dart';
import 'package:dailyroutines/services/session_storage_service.dart';
import 'package:flutter/material.dart';

class FlutterApiDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<bool>(
      future: checkSession(),
      builder: (buildContext, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            // Return your login here
            return LoginPage();
          }
          // Return your home here
          return HomePage();
        } else {
          // Return loading screen while reading preferences
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  Future<bool> checkSession() async {
    var sessionStorage = await SessionStorageService.getInstance();
    debugPrint(sessionStorage.checkSession().toString());
    return sessionStorage.checkSession();
  }
}
