import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/repositories/activity_repository_impl.dart';
import '../../../domain/entities/activity.dart';
import '../../../domain/entities/page.dart';
import '../../../main.dart';
import '../screens/activity_details_screen.dart';
import 'state/activity_list_state.dart';

final activityListViewModelProvider =
    StateNotifierProvider.autoDispose<ActivityListViewModel, ActivityListState>(
        (ref) => ActivityListViewModel(ref));

class ActivityListViewModel extends StateNotifier<ActivityListState> {
  late final Ref ref;

  ActivityListViewModel(this.ref) : super(ActivityListState.initial());

  Future<EntityPage<Activity>> fetchActivities({int pageNumber = 0}) async {
    try {
      final newActivities = await ref
          .read(activityRepositoryProvider)
          .getActivities(pageNumber: pageNumber);
      return newActivities;
    } catch (error) {
      return EntityPage(list: List.empty(), total: 0);
    }
  }

  Future<Activity> getActivityDetails(Activity activity) async {
    state = state.copyWith(isLoading: true);

    try {
      final activityDetails = await ref
          .read(activityRepositoryProvider)
          .getActivityById(id: activity.id);
      state = state.copyWith(isLoading: false);
      return activityDetails;
    } catch (error) {
      // Handle error
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  void backToHome() {
    navigatorKey.currentState?.pop();
  }

  void goToActivity(Activity activityDetails) {
    navigatorKey.currentState?.push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: ActivityDetailsScreen(activity: activityDetails),
        ),
      ),
    );
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}
