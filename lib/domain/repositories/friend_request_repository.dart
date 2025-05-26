import '../entities/enum/friend_request_status.dart';
import '../entities/friend_request.dart';
import '../entities/page.dart';
import '../entities/user.dart';

abstract class FriendRequestRepository {
  Future<EntityPage<User>> getPendingRequestUsers({int pageNumber});

  Future<FriendRequestStatus?> getStatus(String userId);

  Future<int> sendRequest(String userId);

  Future<FriendRequest> accept(String userId);

  Future<FriendRequest> reject(String userId);

  Future<FriendRequest> cancel(String userId);
}
