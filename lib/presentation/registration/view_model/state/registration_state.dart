
class RegistrationState {
  final String firstname;
  final String lastname;
  final String username;
  final String email; // ✅ nuevo campo
  final String password;
  final String checkPassword;
  final bool isLogging;

  const RegistrationState({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.password,
    required this.checkPassword,
    required this.isLogging,
  });

  factory RegistrationState.initial() {
    return const RegistrationState(
      firstname: '',
      lastname: '',
      username: '',
      email: '',
      password: '',
      checkPassword: '',
      isLogging: false,
    );
  }

  RegistrationState copyWith({
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? password,
    String? checkPassword,
    bool? isLogging,
  }) {
    return RegistrationState(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      checkPassword: checkPassword ?? this.checkPassword,
      isLogging: isLogging ?? this.isLogging,
    );
  }
}
