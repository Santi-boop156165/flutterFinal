import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;

  final String? firstname;

  final String? lastname;

  final String username;

  const User(
      {required this.id,
      required this.username,
      required this.firstname,
      required this.lastname});

  @override
  List<Object?> get props => [id, username, firstname, lastname];
}
