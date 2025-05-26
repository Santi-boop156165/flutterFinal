import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/repositories/activity_repository_impl.dart';
import '../../../../domain/entities/activity.dart';
import '../../../../main.dart';
import '../../../my_activities/screens/activity_details_screen.dart';
import '../../../my_activities/view_model/activity_list_view_model.dart';
import '../../user/view_model/profile_picture_view_model.dart';
import 'state/activity_item_state.dart';

final activityItemViewModelProvider = StateNotifierProvider.family<
    ActivityItemViewModel,
    ActivityItemState,
    String>((ref, activityId) => ActivityItemViewModel(ref, activityId));

class ActivityItemViewModel extends StateNotifier<ActivityItemState> {
  final String activityId;
  final Ref ref;
  final TextEditingController commentController = TextEditingController();

  ActivityItemViewModel(this.ref, this.activityId)
      : super(ActivityItemState.initial());

  void setActivity(Activity activity) {
    state = state.copyWith(activity: activity);
  }

  void getProfilePicture(String userId) async {
    ref
        .read(profilePictureViewModelProvider(userId).notifier)
        .getProfilePicture(userId);
  }

  Future<Activity> getActivityDetails(Activity activity) async {
    try {
      ref.read(activityListViewModelProvider.notifier).setIsLoading(true);
      final activityDetails = await ref
          .read(activityRepositoryProvider)
          .getActivityById(id: activity.id);
      return activityDetails;
    } catch (error) {
      // Handle error
      rethrow;
    }
  }

  void goToActivity(Activity activityDetails) {
    Future.delayed(const Duration(milliseconds: 500), () {
      ref.read(activityListViewModelProvider.notifier).setIsLoading(false);
    });

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
}
