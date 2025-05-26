import 'dart:typed_data';

import '../../data/model/request/edit_password_request.dart';
import '../../data/model/request/edit_profile_request.dart';
import '../../data/model/request/login_request.dart';
import '../../data/model/request/registration_request.dart';
import '../../data/model/request/send_new_password_request.dart';
import '../../data/model/response/login_response.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<int> register(RegistrationRequest request);

  Future<LoginResponse> login(LoginRequest request);

  Future<void> logout();

  Future<void> delete();

  Future<void> sendNewPasswordByMail(SendNewPasswordRequest request);

  Future<void> editPassword(EditPasswordRequest request);

  Future<void> editProfile(EditProfileRequest request);

  Future<List<User>> search(String text);

  Future<Uint8List?> downloadProfilePicture(String id);

  Future<void> uploadProfilePicture(Uint8List file);
}
