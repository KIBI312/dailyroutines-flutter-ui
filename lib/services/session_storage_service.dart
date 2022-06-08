import 'dart:async';
import 'dart:convert';

import 'package:dailyroutines/constants/api_path.dart';
import 'package:dailyroutines/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SessionStorageService {
  static SessionStorageService? manager;
  static SharedPreferences? _prefs;
  Timer? _authTimer;

  static Future<SessionStorageService> getInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return manager ??= SessionStorageService();
  }

  void saveAccessToken(String tokenModel) {
    var tokenData = TokenModel.fromJson(jsonDecode(tokenModel));
    var tokenJson = jsonEncode(tokenData.toJson());
    _prefs!.setString('tokenData', tokenJson);
    _autoRefreshToken(tokenData.expiresIn);
  }

  String? retriveAccessToken() {
    var tokenJson = _prefs!.getString('tokenData');
    if (tokenJson == null) return null;
    return TokenModel.fromJson(jsonDecode(tokenJson)).accessToken;
  }

  String? retriveRefreshToken() {
    var tokenJson = _prefs!.getString('tokenData');
    if (tokenJson == null) return null;
    return TokenModel.fromJson(jsonDecode(tokenJson)).refreshToken;
  }

  void clearUserData() {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    _prefs!.remove('tokenData');
  }

  Future<void> refreshAccessToken() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    var refreshToken = retriveRefreshToken();
    var res = await http.post(ApiPath.KEYCLOAK_AUTH, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "client_id": "routines",
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
    });
    saveAccessToken(res.body);
  }

  void _autoRefreshToken(int expiresIn) {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    _authTimer = Timer(Duration(seconds: expiresIn), refreshAccessToken);
  }
}
