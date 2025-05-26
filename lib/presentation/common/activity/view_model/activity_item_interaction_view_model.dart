import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state/activity_item_interaction_state.dart';

final activityItemInteractionViewModelProvider = StateNotifierProvider.family<
        ActivityItemInteractionViewModel, ActivityItemInteractionState, String>(
    (ref, activityId) => ActivityItemInteractionViewModel(ref, activityId));

class ActivityItemInteractionViewModel
    extends StateNotifier<ActivityItemInteractionState> {
  final String activityId;
  final Ref ref;

  ActivityItemInteractionViewModel(this.ref, this.activityId)
      : super(ActivityItemInteractionState.initial());

  void toggleComments() {
    state = state.copyWith(displayComments: !state.displayComments);
  }
}
