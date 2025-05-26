import 'package:equatable/equatable.dart';

import '../../../domain/entities/activity.dart';
import '../../../domain/entities/activity_comment.dart';
import '../../../domain/entities/enum/activity_type.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/entities/user.dart';
import 'activity_comment_response.dart';
import 'location_response.dart';
import 'user_response.dart';

class ActivityResponse extends Equatable {
  final String id;
  final ActivityType type;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final double distance;
  final double speed;
  final double time;
  final Iterable<LocationResponse> locations;
  final UserResponse user;

  final double likesCount;

  final bool hasCurrentUserLiked;

  final Iterable<ActivityCommentResponse> comments;

  const ActivityResponse(
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

  factory ActivityResponse.fromMap(Map<String, dynamic> map) {
    final activityTypeString = map['type']?.toString().toLowerCase();
    final activityType = ActivityType.values.firstWhere(
      (type) => type.name.toLowerCase() == activityTypeString,
      orElse: () => ActivityType.running,
    );

    return ActivityResponse(
      id: map['id'].toString(),
      type: activityType,
      startDatetime: DateTime.parse(map['startDatetime']),
      endDatetime: DateTime.parse(map['endDatetime']),
      distance: map['distance'].toDouble(),
      speed: map['speed'] is String
          ? double.parse(map['speed'])
          : map['speed'].toDouble(),
      time: map['time'].toDouble(),
      likesCount: map['likesCount'].toDouble(),
      hasCurrentUserLiked: map['hasCurrentUserLiked'],
      locations: (map['locations'] as List<dynamic>)
          .map<LocationResponse>((item) => LocationResponse.fromMap(item))
          .toList(),
      user: UserResponse.fromMap(
        map['user'],
      ),
      comments: (map['comments'] as List<dynamic>)
          .map<ActivityCommentResponse>(
              (item) => ActivityCommentResponse.fromMap(item))
          .toList(),
    );
  }

  Activity toEntity() {
    final activityLocations = locations.map<Location>((location) {
      return Location(
        id: location.id,
        datetime: location.datetime,
        latitude: location.latitude,
        longitude: location.longitude,
      );
    }).toList()
      ..sort((a, b) => a.datetime.compareTo(b.datetime));

    final activityComments = comments.map<ActivityComment>((comment) {
      return ActivityComment(
        id: comment.id,
        createdAt: comment.createdAt,
        user: comment.user.toEntity(),
        content: comment.content,
      );
    }).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return Activity(
        id: id,
        type: type,
        startDatetime: startDatetime,
        endDatetime: endDatetime,
        distance: distance,
        speed: speed,
        time: time,
        locations: activityLocations,
        likesCount: likesCount,
        hasCurrentUserLiked: hasCurrentUserLiked,
        user: User(
            id: user.id,
            username: user.username,
            firstname: user.firstname,
            lastname: user.lastname),
        comments: activityComments);
  }
}
