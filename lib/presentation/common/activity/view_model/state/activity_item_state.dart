import '../../../../../domain/entities/activity.dart';

class ActivityItemState {
  final Activity? activity;

  const ActivityItemState({this.activity});

  factory ActivityItemState.initial() {
    return const ActivityItemState(activity: null);
  }

  ActivityItemState copyWith({Activity? activity}) {
    return ActivityItemState(activity: activity ?? this.activity);
  }
}
