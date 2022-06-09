import 'package:dailyroutines/constants/api_path.dart';
import 'package:dailyroutines/models/api_response.dart';
import 'package:dailyroutines/models/server_message.dart';
import 'package:dailyroutines/pages/login_page.dart';
import 'package:dailyroutines/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.username}) : super(key: key);
  final String title = 'Home Page';
  final String username;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _serverMessage = '';
  Color _serverMessageStyleColor = Colors.blue;

  _fetchSecuredServerMessage() async {
    var apiService = await RestApiService.getInstance();
    final response = await apiService.apiGetSecured<ServerMessage>(
        ApiPath.SECURED_PATH, (json) => ServerMessage.fromJson(json));
    _updateState(response);
  }

  void _updateState(ApiResponse<ServerMessage> response) {
    if (response.code == 200) {
      _updateServerMessage(response.body);
      _updateServerMessageStyleColor(Colors.blue);
    } else {
      final requestFailedMsg =
          "Failed to fetch data from: ${ApiPath.baseApiUrl}";
      _updateServerMessage(new ServerMessage(message: requestFailedMsg));
      _updateServerMessageStyleColor(Colors.red);
    }
  }

  void _updateServerMessage(ServerMessage? serverMessage) {
    setState(() {
      _serverMessage = serverMessage!.message;
    });
  }

  void _updateServerMessageStyleColor(MaterialColor newColor) {
    setState(() {
      _serverMessageStyleColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: GestureDetector(
            onTap: () {
              debugPrint("Future menu");
            },
            child: Icon(
              Icons.menu,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Username: ${widget.username}"),
            ),
            Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Icon(
                    Icons.portrait,
                    size: 26.0,
                  ),
                ))
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          child: Text('Secured API'),
                          onPressed: () => _fetchSecuredServerMessage(),
                        )
                      ],
                    )
                  ],
                ),
                Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '$_serverMessage',
                    style: new TextStyle(
                        inherit: true,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decorationStyle: TextDecorationStyle.wavy,
                        color: _serverMessageStyleColor),
                  ),
                ])
              ],
            ),
          ),
        ));
  }
}
