import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

class UserResponse extends Equatable {
  final String id;
  final String? firstname;

  final String? lastname;

  final String username;

  const UserResponse(
      {required this.id,
      required this.username,
      required this.firstname,
      required this.lastname});

  @override
  List<Object?> get props => [id, username];

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
        id: map['id'].toString(),
        username: map['username'],
        firstname: map['firstname'],
        lastname: map['lastname']);
  }

  User toEntity() {
    return User(
        id: id, username: username, firstname: firstname, lastname: lastname);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}
