import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hello_world/l10n/app_localizations.dart';

import '../../common/core/utils/color_utils.dart';
import '../../common/core/utils/form_utils.dart';
import '../../common/core/utils/ui_utils.dart';
import '../view_model/settings_view_model.dart';
import 'edit_password_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  static const _sectionSpacing = SizedBox(height: 32);
  static const _itemSpacing = SizedBox(height: 16);
  static const _horizontalPadding = EdgeInsets.symmetric(horizontal: 24.0);

  Widget _buildTitle(String title) {
    return Padding(
      padding: _horizontalPadding,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return Padding(
      padding: _horizontalPadding,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: FormUtils.createButtonStyle(color ?? ColorUtils.main),
          onPressed: onPressed,
          icon: Icon(icon, color: ColorUtils.white),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              label,
              style: FormUtils.darkTextFormFieldStyle.copyWith(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, _) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: screen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsViewModelProvider);
    final provider = ref.watch(settingsViewModelProvider.notifier);
    final texts = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(texts.settings),
        backgroundColor: ColorUtils.main,
        foregroundColor: ColorUtils.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: state.isLoading
          ? Center(child: UIUtils.loader)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                _buildTitle("Cuenta"),
                const SizedBox(height: 12),
                _buildButton(
                  context: context,
                  label: texts.edit_profile,
                  icon: Icons.person_outline,
                  onPressed: () => _navigateTo(context, EditProfileScreen()),
                ),
                _itemSpacing,
                _buildButton(
                  context: context,
                  label: texts.edit_password,
                  icon: Icons.lock_outline,
                  onPressed: () => _navigateTo(context, EditPasswordScreen()),
                ),

                _sectionSpacing,
                const Divider(thickness: 1),
                _sectionSpacing,

                _buildTitle("Seguridad"),
                const SizedBox(height: 12),
                _buildButton(
                  context: context,
                  label: texts.logout,
                  icon: Icons.logout,
                  onPressed: provider.logoutUser,
                ),
                _itemSpacing,
                _buildButton(
                  context: context,
                  label: texts.delete_account,
                  icon: Icons.delete_forever,
                  color: ColorUtils.error,
                  onPressed: () => provider.showDeleteAccountAlert(
                    context,
                    texts.ask_account_removal,
                    texts.delete,
                    texts.cancel,
                  ),
                ),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: Text(
                      'App hecha por Santiboop 💡',
                      style: TextStyle(
                        color: ColorUtils.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
