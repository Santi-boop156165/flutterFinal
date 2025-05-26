import 'package:equatable/equatable.dart';

class RegistrationRequest extends Equatable {
  final String firstname;
  final String lastname;
  final String username;
  final String email; 
  final String password;

  const RegistrationRequest({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  @override
  bool get stringify => true;
}
