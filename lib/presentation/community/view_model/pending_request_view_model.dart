import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/repositories/friend_request_repository_impl.dart';
import '../../../domain/entities/page.dart';
import '../../../domain/entities/user.dart';
import 'state/pending_requests_state.dart';

final pendingRequestsViewModelProvider =
    StateNotifierProvider<PendingRequestsViewModel, PendingRequestsState>(
        (ref) => PendingRequestsViewModel(ref));

class PendingRequestsViewModel extends StateNotifier<PendingRequestsState> {
  late final Ref ref;

  PendingRequestsViewModel(this.ref) : super(PendingRequestsState.initial());

  Future<EntityPage<User>> fetchPendingRequests({int pageNumber = 0}) async {
    try {
      final newPendingRequests = await ref
          .read(friendRequestRepositoryProvider)
          .getPendingRequestUsers(pageNumber: pageNumber);
      return newPendingRequests;
    } catch (error) {
      return EntityPage(list: List.empty(), total: 0);
    }
  }

  void setPendingRequest(List<User> users) {
    state = state.copyWith(pendingRequests: users);
  }

  acceptRequest(String userId) {
    state = state.copyWith(isLoading: true);
    return ref
        .read(friendRequestRepositoryProvider)
        .accept((userId))
        .then((value) {
      var requests = state.pendingRequests;
      requests.removeWhere((user) => user.id == userId);
      state = state.copyWith(pendingRequests: requests, isLoading: false);
    });
  }

  rejectRequest(String userId) {
    state = state.copyWith(isLoading: true);
    return ref
        .read(friendRequestRepositoryProvider)
        .reject((userId))
        .then((value) {
      var requests = state.pendingRequests;
      requests.removeWhere((user) => user.id == userId);
      state = state.copyWith(pendingRequests: requests, isLoading: false);
    });
  }
}
