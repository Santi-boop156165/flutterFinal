import 'package:flutter/material.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/core/utils/color_utils.dart';
import '../../community/screens/community_screen.dart';
import '../../my_activities/screens/activity_list_screen.dart';
import '../../new_activity/screens/new_activity_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../view_model/home_view_model.dart';

enum Tabs { home, list, community, settings }

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(homeViewModelProvider);
  final homeViewModel = ref.watch(homeViewModelProvider.notifier);
  final currentIndex = state.currentIndex;

  final tabs = [
    const NewActivityScreen(),
    ActivityListScreen(),
    CommunityScreen(),
    const SettingsScreen(),
  ];

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent, // ← para que se vea el fondo
      body: SafeArea(child: tabs[currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, -1),
              blurRadius: 10,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: GNav(
            backgroundColor: Colors.transparent,
            color: Colors.white70,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.white.withOpacity(0.1),
            gap: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            selectedIndex: currentIndex,
            onTabChange: homeViewModel.setCurrentIndex,
            tabs: [
              GButton(
                icon: Icons.flash_on,
                text: AppLocalizations.of(context)!.start_activity,
              ),
              GButton(
                icon: Icons.list,
                text: AppLocalizations.of(context)!.list,
              ),
              GButton(
                icon: Icons.people,
                text: AppLocalizations.of(context)!.community,
              ),
              GButton(
                icon: Icons.settings,
                text: AppLocalizations.of(context)!.settings,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
