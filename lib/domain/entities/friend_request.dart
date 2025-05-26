import 'package:equatable/equatable.dart';

import 'enum/friend_request_status.dart';

class FriendRequest extends Equatable {
  final FriendRequestStatus? status;

  const FriendRequest({required this.status});

  @override
  List<Object?> get props => [status];
}
