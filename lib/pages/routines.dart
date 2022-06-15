import 'package:dailyroutines/components/nav_drawer.dart';
import 'package:dailyroutines/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class Routines extends StatefulWidget {
  final String title = 'Home Page';
  @override
  _RoutinesState createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
  _fetchRoutines() async {
    var apiService = await RestApiService.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routines'),
      ),
      drawer: NavDrawer(),
    );
  }
}
