import '../../domain/entities/enum/friend_request_status.dart';
import '../model/response/friend_request_response.dart';
import '../model/response/page_response.dart';
import '../model/response/user_response.dart';

class FriendRequestApi {
  static Future<PageResponse<UserResponse>> getPendindRequestUsers(int pageNumber) async {
    final mockUsers = List.generate(5, (index) {
      return UserResponse(
        id: 'user_$index',
        username: 'daibis$index',
        firstname: 'Nombre$index',
        lastname: 'Apellido$index',
      );
    });
    return PageResponse(list: mockUsers, total: mockUsers.length);
  }

  static Future<FriendRequestStatus?> getStatus(String userId) async {
    return FriendRequestStatus.pending;
  }

  static Future<int> sendRequest(String userId) async {
    return 42; // ID ficticio
  }

  static Future<FriendRequestResponse> accept(String userId) async {
    return const FriendRequestResponse(status: FriendRequestStatus.accepted);
  }

  static Future<FriendRequestResponse> reject(String userId) async {
    return const FriendRequestResponse(status: FriendRequestStatus.rejected);
  }

  static Future<FriendRequestResponse> cancel(String userId) async {
    return const FriendRequestResponse(status: FriendRequestStatus.rejected); // No existe `cancelled`, usamos `rejected`
  }
}
