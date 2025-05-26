import '../../data/model/request/activity_request.dart';
import '../entities/activity.dart';
import '../entities/activity_comment.dart';
import '../entities/page.dart';

abstract class ActivityRepository {
  Future<EntityPage<Activity>> getActivities({int pageNumber});

  Future<EntityPage<Activity>> getMyAndMyFriendsActivities({int pageNumber});

  Future<EntityPage<Activity>> getUserActivities(String userId,
      {int pageNumber});

  Future<Activity> getActivityById({required String id});

  Future<String?> removeActivity({required String id});

  Future<Activity?> addActivity(ActivityRequest request);

  Future<Activity> editActivity(ActivityRequest request);

  Future<void> like(String id);

  Future<void> dislike(String id);

  Future<String?> removeComment({required String id});

  Future<ActivityComment?> createComment(String activityId, String comment);

  Future<ActivityComment> editComment(String id, String comment);
}
