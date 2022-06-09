import 'package:dailyroutines/constants/project_colors.dart';
import 'package:dailyroutines/flutter_api_demo_app.dart';
import 'package:dailyroutines/pages/home_page.dart';
import 'package:dailyroutines/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<int> attemptLogIn(String username, String password) async {
    var authService = await AuthService.getInstance();
    return authService.authenticateUser(username, password);
  }

  Future<int> attemptLogOut() async {
    var authService = await AuthService.getInstance();
    return authService.logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Please Log in"),
          centerTitle: true,
          foregroundColor: ProjectColors.blue1,
          backgroundColor: ProjectColors.grey1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var username = _usernameController.text;
                  var statusCode =
                      await attemptLogIn(username, _passwordController.text);
                  if (statusCode == 200) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(username: username)));
                  } else {
                    displayDialog(context, "Something went wrong",
                        "No account was found matching that username and password");
                  }
                },
                child: Text("Log In"),
                style: ElevatedButton.styleFrom(
                  primary: ProjectColors.turqoise,
                  textStyle: TextStyle(color: ProjectColors.blue1),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var statusCode = await attemptLogOut();
                  if (statusCode == 204) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(username: "LogIn")));
                  } else {
                    displayDialog(context, "Something went wrong",
                        "Error on logout attempt");
                  }
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                    primary: ProjectColors.red1,
                    textStyle: TextStyle(color: ProjectColors.blue1)),
              ),
            ],
          ),
        ));
  }
}
