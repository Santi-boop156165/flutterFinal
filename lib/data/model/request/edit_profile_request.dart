import 'package:equatable/equatable.dart';

class EditProfileRequest extends Equatable {
  final String firstname;

  final String lastname;

  const EditProfileRequest({
    required this.firstname,
    required this.lastname,
  });

  @override
  List<Object?> get props => [firstname, lastname];

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  @override
  bool get stringify => true;
}
