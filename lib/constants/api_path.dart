import 'package:flutter_flavor/flutter_flavor.dart';

class ApiPath {
  static final baseKeycloakUrl =
      FlavorConfig.instance.variables["baseKeycloakUrl"];
  static final baseApiUrl = FlavorConfig.instance.variables["baseApiUrl"];

  static final Uri KEYCLOAK_AUTH = Uri.parse(
      '$baseKeycloakUrl/auth/realms/spring-realm/protocol/openid-connect/token');
  static final Uri KEYCLOAK_LOGOUT = Uri.parse(
      '$baseKeycloakUrl/auth/realms/spring-realm/protocol/openid-connect/logout');
  static final Uri SECURED_PATH = Uri.parse('$baseApiUrl/schedule/getRoutines');
  static final Uri ROUTINES_LIST =
      Uri.parse('$baseApiUrl/schedule/getRoutines');
}
