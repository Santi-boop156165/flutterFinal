// lib/data/api/user_api.dart (mockeado)
import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../../core/utils/storage_utils.dart';
import '../../domain/entities/user.dart';
import '../model/request/edit_password_request.dart';
import '../model/request/edit_profile_request.dart';
import '../model/request/login_request.dart';
import '../model/request/registration_request.dart';
import '../model/request/send_new_password_request.dart';
import '../model/response/login_response.dart';
import '../model/response/user_response.dart';
import 'helpers/api_helper.dart';

class UserApi {
  static Future<int> createUser(RegistrationRequest request) async {
    final response = await ApiHelper.makeRequest(
        '${ApiHelper.apiUrl}user/register', 'POST',
        data: request.toMap());
    return response?.data;
  }

  static Future<LoginResponse> login(LoginRequest request) async {
    final response = await ApiHelper.makeRequest(
        '${ApiHelper.apiUrl}user/login', 'POST',
        data: request.toMap());
    return LoginResponse.fromMap(response?.data);
  }

  static Future<void> logout() async {
    await ApiHelper.makeRequest('${ApiHelper.apiUrl}private/user/logout', 'POST');
  }

  static Future<void> delete() async {
    await ApiHelper.makeRequest('${ApiHelper.apiUrl}private/user', 'DELETE');
  }

  static Future<String?> refreshToken() async {
    final response = await ApiHelper.makeRequest(
        '${ApiHelper.apiUrl}user/refreshToken', 'POST',
        data: {'token': await StorageUtils.getRefreshToken()});
    final token = response?.data['token'];
    await StorageUtils.setJwt(token);
    return token;
  }

  static Future<String> sendNewPasswordByMail(SendNewPasswordRequest request) async {
    final response = await ApiHelper.makeRequest(
        '${ApiHelper.apiUrl}user/sendNewPasswordByMail', 'POST',
        queryParams: request.toMap());
    return response?.data;
  }

  static Future<void> editPassword(EditPasswordRequest request) async {
    await ApiHelper.makeRequest(
        '${ApiHelper.apiUrl}private/user/editPassword', 'PUT',
        data: request.toMap());
  }

  static Future<void> editProfile(EditProfileRequest request) async {
    await ApiHelper.makeRequest(
        '${ApiHelper.apiUrl}private/user/editProfile', 'PUT',
        data: request.toMap());
  }

  static Future<List<UserResponse>> search(String text) async {
    final response = await ApiHelper.makeRequest(
        '${ApiHelper.apiUrl}private/user/search', 'GET',
        queryParams: {'searchText': text});
    final list = List<Map<String, dynamic>>.from(response?.data);
    return list.map(UserResponse.fromMap).toList();
  }

  static Future<Uint8List?> downloadProfilePicture(String id) async {
    final user = await StorageUtils.getUser();
    final useCache = user != null && user.id == id;
    final response = await ApiHelper.makeRequest(
      '${ApiHelper.apiUrl}user/picture/download/$id',
      'GET',
      noCache: !useCache,
      responseType: ResponseType.bytes,
    );

    if (response != null &&
        (response.statusCode == 404 || response.statusCode == 500)) {
      return null;
    }

    try {
      return Uint8List.fromList(List<int>.from(response?.data));
    } catch (_) {
      return null;
    }
  }

  static Future<void> uploadProfilePicture(Uint8List file) async {
    await ApiHelper.makeRequest(
      '${ApiHelper.apiUrl}private/user/picture/upload',
      'POST_FORM_DATA',
      data: {'file': MultipartFile.fromBytes(file)},
    );
    final user = await StorageUtils.getUser();
    if (user != null) {
      await ApiHelper.removeCacheForUrl(
          '${ApiHelper.apiUrl}user/picture/download/${user.id}');
    }
  }
}
