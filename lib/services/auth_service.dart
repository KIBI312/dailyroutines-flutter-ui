import 'package:dailyroutines/constants/api_path.dart';
import 'package:dailyroutines/services/session_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static AuthService? service;

  static Future<AuthService> getInstance() async {
    return service ??= AuthService();
  }

  //Login user
  Future<int> authenticateUser(String username, String password) async {
    var res = await http.post(ApiPath.KEYCLOAK_AUTH, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "username": username,
      "password": password,
      "client_id": "routines",
      "grant_type": "password"
    });

    if (res.statusCode == 200) {
      var sessionStorageService = await SessionStorageService.getInstance();
      sessionStorageService.saveAccessToken(res.body);
      return res.statusCode;
    } else {
      debugPrint(
          "An error occured during auth. Status code ${res.statusCode} , body: ${res.body.toString()}");
      return res.statusCode;
    }

    //Logout user
  }

  Future<int> logoutUser() async {
    var sessionStorageService = await SessionStorageService.getInstance();
    var refreshToken = sessionStorageService.retriveRefreshToken();
    var res = await http.post(ApiPath.KEYCLOAK_LOGOUT, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "client_id": "routines",
      "refresh_token": refreshToken,
    });

    if (res.statusCode == 204) {
      sessionStorageService.clearUserData();
      return res.statusCode;
    } else {
      debugPrint(
          "An error occured during logout. Status code ${res.statusCode} , body: ${res.body.toString()}");
      return res.statusCode;
    }
  }
}
