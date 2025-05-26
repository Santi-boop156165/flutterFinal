import '../../../../domain/entities/user.dart';

class PendingRequestsState {
  final bool isLoading;
  final List<User> pendingRequests;
  final int total;

  const PendingRequestsState(
      {required this.isLoading,
      required this.pendingRequests,
      required this.total});

  factory PendingRequestsState.initial() {
    return const PendingRequestsState(
        isLoading: false, pendingRequests: [], total: 0);
  }

  PendingRequestsState copyWith(
      {bool? isLoading, // Updated loading state
      List<User>? pendingRequests,
      int? total}) {
    return PendingRequestsState(
        isLoading: isLoading ?? this.isLoading,
        pendingRequests: pendingRequests ?? this.pendingRequests,
        total: total ?? this.total);
  }
}
