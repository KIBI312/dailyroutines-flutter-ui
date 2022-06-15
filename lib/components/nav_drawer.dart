import 'package:dailyroutines/pages/home_page.dart';
import 'package:dailyroutines/pages/login_page.dart';
import 'package:dailyroutines/pages/routines.dart';
import 'package:dailyroutines/services/auth_service.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
            title: const Text('Routines'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Routines())),
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () => {attemptLogOut(context)},
          )
        ],
      ),
    );
  }

  Future<int> attemptLogOut(context) async {
    var authService = await AuthService.getInstance();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    return authService.logoutUser();
  }
}
