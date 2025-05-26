import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/request/registration_request.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../main.dart';
import 'state/registration_state.dart';

final registrationViewModelProvider =
    StateNotifierProvider.autoDispose<RegistrationViewModel, RegistrationState>(
  (ref) => RegistrationViewModel(ref),
);

class RegistrationViewModel extends StateNotifier<RegistrationState> {
  Ref ref;

  RegistrationViewModel(this.ref) : super(RegistrationState.initial());

  void setFirstname(String? firstname) {
    state = state.copyWith(firstname: firstname);
  }
void setEmail(String? email) {
  state = state.copyWith(email: email);
}
  void setLastname(String? lastname) {
    state = state.copyWith(lastname: lastname);
  }

 void setUsername(String? username) {
  final cleaned = (username ?? '').trim();
  final suffix = DateTime.now().millisecondsSinceEpoch % 10000; // hasta 4 dígitos
  final generatedUsername = cleaned.isEmpty ? 'user_$suffix' : '${cleaned}_$suffix';

  state = state.copyWith(username: generatedUsername);
}

  void setPassword(String? password) {
    state = state.copyWith(password: password);
  }

  void setCheckPassword(String? checkPassword) {
    state = state.copyWith(checkPassword: checkPassword);
  }

  Future<void> submitForm(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      state = state.copyWith(isLogging: true);

      final userRepository = ref.read(userRepositoryProvider);
      final registrationRequest = RegistrationRequest(
        firstname: state.firstname,
        lastname: state.lastname,
        username: state.firstname,
        email: state.email,
        password: state.password,
      );

      try {
        await userRepository.register(registrationRequest);
        navigatorKey.currentState?.pop();
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(error.toString()),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } finally {
        state = state.copyWith(isLogging: false);
      }
    }
  }
}
