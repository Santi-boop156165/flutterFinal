import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/activity.dart';
import '../../../../domain/entities/enum/activity_type.dart';

class ActivityDetailsState {
  final Activity? activity;
  final ActivityType? type;
  final bool isLoading;
  final bool isEditing;
  final GlobalKey boundaryKey;

  const ActivityDetailsState(
      {this.activity,
      this.type,
      required this.isLoading,
      required this.isEditing,
      required this.boundaryKey});

  factory ActivityDetailsState.initial() {
    return ActivityDetailsState(
        isLoading: false, isEditing: false, boundaryKey: GlobalKey());
  }

  ActivityDetailsState copyWith(
      {Activity? activity,
      bool? isLoading,
      ActivityType? type,
      bool? isEditing}) {
    return ActivityDetailsState(
        activity: activity ?? this.activity,
        isLoading: isLoading ?? this.isLoading,
        type: type ?? this.type,
        isEditing: isEditing ?? this.isEditing,
        boundaryKey: boundaryKey);
  }
}
