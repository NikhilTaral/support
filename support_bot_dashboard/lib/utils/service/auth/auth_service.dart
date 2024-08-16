import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as js;
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/extensions.dart';
import 'package:support_bot_dashboard/utils/log.dart';
import 'package:support_bot_dashboard/utils/models/user_profile.dart';
import 'package:support_bot_dashboard/utils/service/auth/okta_auth_result.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage_key.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/secure_storage.dart';

class AuthService {
  static const apiKey =
      '556d0cdcb9696f909bda624731e9d38af85e6d04fb449941837672dc2fab15ba';
  static final SecureStorage _storage = serviceLocator<SecureStorage>();
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;
  String? _idToken;

  Future<bool> authenticate() async {
    clearUserProfile();
    clearTokens();

    final result = await fetchAccessToken();
    if (result == null || !await _storeOktaAuthResult(result)) return false;

    // _userProfile = await getUserProfile();
    // if (_userProfile == null) {
    //   Log.error(
    //       "AuthService failed to retrieve user profile - Authorization has failed");
    //   return false;
    // } else {
    js.window.location.reload();
    return true;
    // }
  }

  Future<OktaAuthResult?> fetchAccessToken() async {
    try {
      //fetch authorization code using below request
      const clientId = EnvConfig.OKTA_APP_ID;
      const authUrl = EnvConfig.OKTA_AUTH_URL;

      const redirectUri = kIsWeb ? EnvConfig.OKTA_REDIRECT_URI : 'com.myexp:/';
      const responseType = 'code';
      const scope = 'openid+profile';
      const state = 'hDBcb3VXMbxzf3dOgHYBs9q5vF99kWMxT4UwA2rvKESYD3Rjer';
      const nonce = '5PDA1QlVeu06KhCikO8OcV9KcUjRKHJzWIcdOre0HG1XiqHI7J';
      const callbackUrl = kIsWeb ? 'auth.html' : 'com.myexp';
      const codeChallengeMethod = 'S256';
      final codeVerifier = getRandomString(44);
      final codeChallenge = generateCodeChallenge(codeVerifier);

      final params = {
        'response_type': responseType,
        'scope': scope,
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'state': state,
        'nonce': nonce,
        'code_challenge': codeChallenge,
        'code_challenge_method': codeChallengeMethod
      };

      var queryString = '?';
      queryString += params.keys.map((key) => "$key=${params[key]}").join("&");

      final url = authUrl + queryString;

      final authResult = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: callbackUrl,
      );
      // Extract authorization code from redirect url
      final code = Uri.parse(authResult).queryParameters['code'];

      if (code != null) {
        //fetch all the tokens using below request
        const tokenUrl = EnvConfig.OKTA_TOKEN_URL;

        const grantType = 'authorization_code';
        final tokenParams = {
          'grant_type': grantType,
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'code': code,
          'code_verifier': codeVerifier
        };

        final response =
            await http.post(Uri.parse(tokenUrl), body: tokenParams);

        final responseJson = _response(response);
        if (responseJson == null) {
          return null;
        }

        if (responseJson is Map<String, dynamic>) {
          return OktaAuthResult.fromJson(responseJson);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      Log.error("AuthService startOktaSignIn failed with error $e");
      return null;
    }
  }

  Future<bool> _storeOktaAuthResult(OktaAuthResult? oktaAuthResult) async {
    if (oktaAuthResult == null) return false;
    _idToken = oktaAuthResult.idToken;
    await _storage.setString(oktaAuthResult.accessToken,
        key: SecureStorageKey.accessToken);
        print("oktaAuthResult.accessToken >>> ${oktaAuthResult.accessToken}");
    await _storage.setString(oktaAuthResult.idToken,
        key: SecureStorageKey.idToken);
    // await _storage.setString(oktaAuthResult.refreshToken,
    //     key: SecureStorageKey.refreshToken);
    return true;
  }

  Future<OktaAuthResult?> refreshToken() async {
    try {
      const clientId = EnvConfig.OKTA_APP_ID;
      const tokenUrl = EnvConfig.OKTA_TOKEN_URL;

      const redirectUri = kIsWeb ? EnvConfig.OKTA_REDIRECT_URI : 'com.myexp:/';
      const scope = 'offline_access openid profile';
      const grantType = 'refresh_token';
      final requestRefreshToken =
          await _storage.getString(key: SecureStorageKey.refreshToken);

      final tokenParams = {
        'grant_type': grantType,
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'scope': scope,
        'refresh_token': requestRefreshToken
      };

      final response = await http.post(Uri.parse(tokenUrl), body: tokenParams);
      final responseJson = _response(response);
      if (responseJson == null) {
        return null;
      }

      if (responseJson is Map<String, dynamic>) {
        return OktaAuthResult.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (e) {
      Log.error("AuthService refreshToken failed with error $e");
      return null;
    }
  }

  String generateCodeChallenge(String codeVerifier) {
    var bytes = utf8.encode(codeVerifier);
    var digest = sha256.convert(bytes);
    var codeChallenge = base64UrlEncode(digest.bytes);

    if (codeChallenge.endsWith('=')) {
      codeChallenge = codeChallenge.substring(0, codeChallenge.length - 1);
    }

    return codeChallenge;
  }

  FutureOr<bool> checkValidToken() async {
    _idToken = await _storage.getString(key: SecureStorageKey.idToken);
    if (_idToken == null) {
      return false;
    } else {
      return _isValidToken(_idToken);
    }
  }

  Future<bool> _isValidToken(String? token) async {
    if (token == null) return false;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(_idToken!);
    int expiryTime = decodedToken['exp'] * 1000; // convert to milliseconds
    DateTime expiryDateTime = DateTime.fromMillisecondsSinceEpoch(expiryTime);
    final isTokenExpired = !(DateTime.now().isBefore(expiryDateTime));
    final audience = decodedToken['aud'] as String?;
    final hasValidAud = audience == EnvConfig.OKTA_APP_ID;
    if (!isTokenExpired && hasValidAud) return true;
    final result = await refreshToken();
    if (!await _storeOktaAuthResult(result)) return false;
    return result != null;
  }

  Future<bool> isAuthenticated() async {
    _idToken = await _storage.getString(key: SecureStorageKey.idToken);
    if (_idToken == null) {
      return false;
    }

    final hasValidToken = _isValidToken(_idToken);

    // _userProfile = await getUserProfile();
    final hasUserProfile = (_userProfile != null);
    if (await hasValidToken && hasUserProfile) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getUsername() async {
    if (_idToken != null) {
      return JwtDecoder.tryDecode(_idToken!)?["name"];
    } else {
      return null;
    }
  }

  Future<UserProfile?> getUserProfile() async {
    if (_userProfile != null) return _userProfile;

    String? username;

    username = await getUsername();

    if (username == null) {
      return null;
    }

    final apiProvider = serviceLocator<ApiProvider>();
    final response =
        await apiProvider.getData(url: 'profile', body: {
      'username': username,
    });

    if (response == null) {
      return null;
    }
    try {
      UserProfile? value;
      final List<dynamic>? values = response['value'];
      if (values?.isNotEmpty == true) {
        value = UserProfile.fromJson(values![0]);
        return value;
      }
      return value;
    } catch (e) {
      Log.error('AuthService getUserProfile failed with error: $e');
      return null;
    }
  }

  Future<void> clearTokens() async {
    _idToken = null;
    await _storage.remove(key: SecureStorageKey.accessToken);
    await _storage.remove(key: SecureStorageKey.idToken);
  }

  Future<void> clearUserProfile() async {
    _userProfile = null;
    await serviceLocator<LocalStorage>()
        .remove(localStorageKey: LocalStorageKey.staffSelectedAgentUsername);
  }

  /// Returns users id token for API calls - not access token
  Future<String?> getAccessToken() async {
    // TODO: Refresh token as needed
    final idToken = await _storage.getString(key: SecureStorageKey.idToken);
    if (await _isValidToken(idToken)) {
      return idToken;
    } else {
      // TODO: Setup notifier to force login
    }
    return null;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        throw Exception(
            'Okta Auth - Network response failed with status code: ${response.statusCode}');
    }
  }
}
