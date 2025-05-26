import 'package:flutter/material.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/core/utils/color_utils.dart';
import '../../common/core/utils/form_utils.dart';
import '../../common/core/utils/ui_utils.dart';
import '../../common/core/validators/login_validators.dart';
import '../../registration/screens/registration_screen.dart';
import '../../send_new_password/screens/send_new_password_screen.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends HookConsumerWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(loginViewModelProvider);
  final provider = ref.watch(loginViewModelProvider.notifier);

  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: state.isLogging
          ? Center(child: UIUtils.loader)
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.hello},',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: AppLocalizations.of(context)!.email,
                            hintStyle:
                                const TextStyle(color: Colors.white54),
                            prefixIcon: const Icon(Icons.email,
                                color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                              LoginValidators.email(context, value),
                          onSaved: (value) {
                            provider.setUsername(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: AppLocalizations.of(context)!.password,
                            hintStyle:
                                const TextStyle(color: Colors.white54),
                            prefixIcon: const Icon(Icons.lock,
                                color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                              LoginValidators.password(context, value),
                          onSaved: (value) {
                            provider.setPassword(value);
                          },
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            provider.submitForm(context, formKey);
                          },
                          icon: const Icon(Icons.login),
                          label: Text(
                            AppLocalizations.of(context)!.login_page,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: RegistrationScreen(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.app_registration,
                              color: Colors.white),
                          label: Text(
                            AppLocalizations.of(context)!.registration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: SendNewPasswordScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.send_new_password,
                            style: const TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    ),
  );
}

}
