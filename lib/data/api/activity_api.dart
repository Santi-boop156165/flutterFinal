import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../model/request/activity_request.dart';
import '../model/response/activity_comment_response.dart';
import '../model/response/activity_response.dart';
import '../model/response/location_response.dart';
import '../model/response/page_response.dart';
import '../model/response/user_response.dart';
import '../../../domain/entities/enum/activity_type.dart';

class ActivityApi {
  static String url = 'https://mock-api.local/private/activity/';

  static Future<PageResponse<ActivityResponse>> getActivities(int pageNumber) async {
    final activitiesInit = List.generate(5, (i) => activity('$i'));
    return PageResponse(list: activitiesInit, total: activitiesInit.length);
  }

  static Future<PageResponse<ActivityResponse>> getMyAndMyFriendsActivities(int pageNumber) async {
    return getActivities(pageNumber);
  }

  static Future<PageResponse<ActivityResponse>> getUserActivities(String userId, int pageNumber) async {
    final activities = List.generate(3, (i) => activity('$i', userId: userId));
    return PageResponse(list: activities, total: activities.length);
  }

  static Future<ActivityResponse> getActivityById(String id) async {
    return activity(id);
  }

  static Future<String?> removeActivity(String id) async {
    return 'Actividad $id eliminada';
  }

  static Future<ActivityResponse?> addActivity(ActivityRequest request) async {
    return activity(const Uuid().v4());
  }

  static Future<ActivityResponse> editActivity(ActivityRequest request) async {
    return activity(const Uuid().v4());
  }

  static Future<void> like(String activityId) async {}
  static Future<void> dislike(String activityId) async {}

  static Future<ActivityCommentResponse> createComment(String activityId, String comment) async {
    return ActivityCommentResponse(
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
      user: userInit(),
      content: comment,
    );
  }

  static Future<ActivityCommentResponse> editComment(String id, String comment) async {
    return createComment('activity_mock', comment);
  }

  static Future<String?> removeComment(String id) async {
    return 'Comentario $id eliminado';
  }


  static ActivityResponse activity(String id, {String? userId}) {
    final now = DateTime.now();
    return ActivityResponse(
      id: id,
      type: ActivityType.running,
      startDatetime: now.subtract(const Duration(hours: 1)),
      endDatetime: now,
      distance: 5.0,
      speed: 2.5,
      time: 3600,
      likesCount: 3,
      hasCurrentUserLiked: false,
      locations: [
        LocationResponse(
          id: 'loc1',
          datetime: now.subtract(const Duration(minutes: 30)),
          latitude: 10.0,
          longitude: 20.0,
        )
      ],
      user: userInit(id: userId ?? 'user_$id'),
      comments: [],
    );
  }

  static UserResponse userInit({String id = 'user_1'}) {
    return UserResponse(
      id: id,
      username: 'mockuser',
      firstname: 'Don',
      lastname: 'Jhoe',
    );
  }
}
