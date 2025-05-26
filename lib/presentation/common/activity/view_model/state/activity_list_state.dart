import '../../../../../domain/entities/activity.dart';

class ActivityListWidgetState {
  final List<List<Activity>> groupedActivities;

  const ActivityListWidgetState({required this.groupedActivities});

  factory ActivityListWidgetState.initial() {
    return const ActivityListWidgetState(groupedActivities: []);
  }

  ActivityListWidgetState copyWith({List<List<Activity>>? groupedActivities}) {
    return ActivityListWidgetState(
        groupedActivities: groupedActivities ?? this.groupedActivities);
  }
}
