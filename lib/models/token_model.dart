class TokenModel {
  final String accessToken;
  final int expiresIn;
  final int refreshExpiresIn;
  final String refreshToken;
  final String tokenType;
  final int notBeforePolicy;
  final String sessionState;
  final String scope;

  TokenModel(
      this.accessToken,
      this.expiresIn,
      this.refreshExpiresIn,
      this.refreshToken,
      this.tokenType,
      this.notBeforePolicy,
      this.sessionState,
      this.scope);

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        json['access_token'],
        json['expires_in'],
        json['refresh_expires_in'],
        json['refresh_token'],
        json['token_type'],
        json['not-before-policy'],
        json['session_state'],
        json['scope']);
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
      'refresh_expires_in': refreshExpiresIn,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'not-before-policy': notBeforePolicy,
      'session_state': sessionState,
      'scope': scope,
    };
  }
}
