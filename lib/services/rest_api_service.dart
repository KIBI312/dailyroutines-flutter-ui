import 'dart:convert';

import 'package:dailyroutines/models/api_response.dart';
import 'package:dailyroutines/services/session_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestApiService {
  static RestApiService? service;

  static Future<RestApiService> getInstance() async {
    return service ??= RestApiService();
  }

  Future<ApiResponse<T>> apiGetSecured<T>(
      Uri uri, T Function(Map<String, dynamic>) fromJson) async {
    final headers = await createAuthHeader();
    if (headers == null) return ApiResponse<T>(null, 401);
    final response = await http.get(uri, headers: headers);
    return parseResponse(response, fromJson);
  }

  ApiResponse<T> parseResponse<T>(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    if (response.statusCode == 200) {
      final parsedBody = deserialize<T>(response.body, (x) => fromJson(x));
      debugPrint(parsedBody.toString());
      return ApiResponse<T>(parsedBody, response.statusCode);
    } else {
      final requestFailedMsg =
          "Failed to fetch data from :${response.request!.url}";
      debugPrint(requestFailedMsg);
      return ApiResponse<T>(null, response.statusCode);
    }
  }

  T deserialize<T>(
    String json,
    T factory(Map<String, dynamic> data),
  ) {
    return factory(jsonDecode(json)[0] as Map<String, dynamic>);
  }

  Future<Map<String, String>?> createAuthHeader() async {
    var sessionStorageService = await SessionStorageService.getInstance();
    var accessToken = sessionStorageService.retriveAccessToken();
    if (accessToken == null) {
      debugPrint("No access token");
      return null;
    }
    return {"Authorization": "Bearer $accessToken"};
  }
}
