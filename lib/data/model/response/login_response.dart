import 'user_response.dart';

class LoginResponse {
  final String refreshToken;
  final String token;
  final UserResponse user;
  final String message;
  const LoginResponse({
    required this.refreshToken,
    required this.token,
    required this.user,
    required this.message,
  });
  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      refreshToken: map['refreshToken']?.toString() ?? '',
      token: map['token']?.toString() ?? '',
      user: UserResponse.fromMap(map['user']),
      message: map['message']?.toString() ?? '',
    );
  }
}
