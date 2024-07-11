class OktaAuthResult {
  String accessToken;
  // String refreshToken;
  String idToken;

  OktaAuthResult(
      this.accessToken,
      // this.refreshToken,
      this.idToken,
      );

  OktaAuthResult.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        // refreshToken = json.containsKey('refresh_token')? json['refresh_token']:'',
        idToken = json['id_token'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OktaAuthResult &&
              runtimeType == other.runtimeType &&
              accessToken == other.accessToken &&
              idToken == other.idToken;

  @override
  int get hashCode =>
      accessToken.hashCode ^ idToken.hashCode;
}
