// lib/data/api/helpers/api_helper.dart (mockeado)
import 'dart:typed_data';
import 'dart:convert';
import 'package:dio/dio.dart';

class ApiHelper {
  static const String apiUrl = 'https://mocked-api.local/api/';

  static Future<Response?> makeRequest(
    String url,
    String method, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    ResponseType? responseType,
    bool noCache = false,
  }) async {
    return _handleMock(url, method);
  }

  static Future<Response?> _handleMock(String url, String method) async {
    if (url.contains('user/register')) {
      return _response(123);
    } else if (url.contains('user/login')) {
      return _response({
        "token": "mocked_jwt",
        "refreshToken": "mocked_refresh_token",
        "user": {"id": 1, "username": "mock_user"}
      });
    } else if (url.contains('user/refreshToken')) {
      return _response({"token": "mocked_jwt_refreshed"});
    } else if (url.contains('user/sendNewPasswordByMail')) {
      return _response("Correo enviado correctamente.");
    } else if (url.contains('private/user/search')) {
      return _response([
        {"id": 1, "username": "mocked_user_1"},
        {"id": 2, "username": "mocked_user_2"}
      ]);
    } else if (url.contains('user/picture/download')) {
      return _response(Uint8List.fromList([0, 1, 2, 3]),
          responseType: ResponseType.bytes);
    }

    return _response(null);
  }

  static Future<Response<T>> _response<T>(
    T data, {
    int statusCode = 200,
    ResponseType responseType = ResponseType.json,
  }) async {
    return Response<T>(
      data: data,
      statusCode: statusCode,
      requestOptions: RequestOptions(path: '', responseType: responseType),
    );
  }

  static Future<void> removeCacheForUrl(String url) async {
    // No-op en mock
  }
}
