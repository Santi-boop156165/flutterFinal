import 'package:equatable/equatable.dart';

import 'activity_comment.dart';
import 'enum/activity_type.dart';
import 'location.dart';
import 'user.dart';

class Activity extends Equatable {
  final String id;

  final ActivityType type;

  final DateTime startDatetime;
  final DateTime endDatetime;
  final double distance;

  final double speed;

  final double time;

  final Iterable<Location> locations;

  final User user;

  final double likesCount;

  final bool hasCurrentUserLiked;

  final Iterable<ActivityComment> comments;

  const Activity(
      {required this.id,
      required this.type,
      required this.startDatetime,
      required this.endDatetime,
      required this.distance,
      required this.speed,
      required this.time,
      required this.locations,
      required this.user,
      required this.likesCount,
      required this.hasCurrentUserLiked,
      required this.comments});

  Activity copy(
      {ActivityType? type,
      double? likesCount,
      bool? hasCurrentUserLiked,
      Iterable<ActivityComment>? comments}) {
    return Activity(
        id: id,
        type: type ?? this.type,
        startDatetime: startDatetime,
        endDatetime: endDatetime,
        distance: distance,
        speed: speed,
        time: time,
        locations: locations,
        user: user,
        likesCount: likesCount ?? this.likesCount,
        hasCurrentUserLiked: hasCurrentUserLiked ?? this.hasCurrentUserLiked,
        comments: comments ?? this.comments);
  }

  @override
  List<Object?> get props => [
        id,
        type,
        startDatetime,
        endDatetime,
        distance,
        speed,
        time,
        ...locations,
        user,
        likesCount,
        hasCurrentUserLiked,
        ...comments
      ];
}
