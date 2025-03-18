import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/error/exceptions.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/log.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';

class ApiProvider {
  final _authService = serviceLocator<AuthService>();
  final _apiBaseUrl = EnvConfig.EXP_API_URL;

  Future<Uint8List?> downloadCsv({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "application/json";
    final token = await serviceLocator<AuthService>().getAccessToken();
    headers["Authorization"] = "Bearer $token";

    try {
      final response = await http.post(
        Uri.parse("$_apiBaseUrl/$url"),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
       final bytes = response.bodyBytes;
        return bytes;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      Log.error("downloadCsv failed with timeout");
      return null;
    } catch (e) {
      Log.error("downloadCsv failed with error $e");
      return null;
    }
  }

 

  Future<dynamic> getData({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "application/json";
    final token = await serviceLocator<AuthService>().getAccessToken();
    headers["Authorization"] = "Bearer $token";

    try {
      dynamic responseJson;

      final response = await http.post(
        Uri.parse("$_apiBaseUrl/$url"),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode != 200) return null;
      responseJson = _response(response);

      if (responseJson == null) return null;

      return responseJson;
    } on TimeoutException catch (_) {
      Log.error("ApiProvider get failed with timeout");
      return null;
    } catch (e) {
      Log.error("ApiProvider get failed with error $e");
      return null;
    }
  }

  Future<Uint8List?> fetchUserImage(String photoUrl) async {
    final apiBaseUrl = serviceLocator<ApiProvider>().getApiBaseUrl();
    final headers = <String, String>{};
    headers["Content-Type"] = "application/json";
    final token = await serviceLocator<AuthService>().getAccessToken();
    headers["Authorization"] = "Bearer $token";

    try {
      if (photoUrl.isEmpty) {
        return null;
      }

      final response = await http.post(
        Uri.parse("$apiBaseUrl/images"),
        headers: headers,
        body: json.encode(
          {
            'url': photoUrl,
          },
        ),
      );

      if (response.statusCode != 200) return null;

      final result = Uri.parse(response.body).data?.contentAsBytes();
      return result;
    } catch (e) {
      Log.error("ApiProvider failed fetchUserImage with error: $e");
      return null;
    }
  }

  Future<String?> getUserUuid() async {
    final profile = await _authService.getUserProfile();
    return profile?.agentUuid;
  }

  Future<String?> getUserEmail() async {
    final profile = await _authService.getUserProfile();
    return profile?.email;
  }

  String getApiBaseUrl() {
    return _apiBaseUrl;
  }

  Future<dynamic> uploadFile({
    BuildContext? context,
    required String subUrl,
    required String baseUrl,
    required File file,
    Map<String, String>? body,
  }) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "multipart/form-data";

    try {
      dynamic responseJson;

      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl$subUrl"),
      );

      request.headers.addAll(headers);

      if (body != null) {
        request.fields.addAll(body);
      }

      if (!file.existsSync()) {
        throw FileSystemException("File not found: ${file.path}");
      }

      request.files.add(http.MultipartFile(
        "file",
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: "file ${file.path}",
      ));

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = await response.stream.bytesToString();

        if (responseJson == null) return null;
        return responseJson;
      } else if (response.statusCode == 401 ||
          response.statusCode == 402 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      Log.error("ApiProvider get  failed with timeout");
      return null;
    } catch (e) {
      Log.error("ApiProvider get failed with error $e");
      return null;
    }
  }

  Future<dynamic> getResource({
    required String subUrl,
    required String baseUrl,
    BuildContext? context,
    Map<String, dynamic>? body,
  }) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "application/json";

    try {
      dynamic responseJson;

      final response = await http.get(
        Uri.parse("$baseUrl$subUrl"),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = _response(response);

        if (responseJson == null) return null;
        return responseJson;
      } else if (response.statusCode == 401 ||
          response.statusCode == 402 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      Log.error("ApiProvider get  failed with timeout");
      return null;
    } catch (e) {
      Log.error("ApiProvider get failed with error $e");
      return null;
    }
  }

  

  Future<dynamic> putData({
    BuildContext? context,
    required String subUrl,
    required String baseUrl,
    Map<String, dynamic>? body,
  }) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "application/json";

    try {
      dynamic responseJson;

      final response = await http.put(
        Uri.parse("$baseUrl$subUrl"),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = _response(response);

        if (responseJson == null) return null;
        return responseJson;
      } else if (response.statusCode == 401 ||
          response.statusCode == 402 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      Log.error("ApiProvider get  failed with timeout");
      return null;
    } catch (e) {
      Log.error("ApiProvider get failed with error $e");
      return null;
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        Log.error(response.body.toString());
        throw BadRequestException(response.body.toString());
      case 401:
        Log.error(response.body.toString());
        throw UnauthorizedException(response.body.toString());
      case 403:
        Log.error(response.body.toString());
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        Log.error(response.body.toString());
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
