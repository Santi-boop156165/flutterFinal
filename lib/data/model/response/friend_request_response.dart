import 'package:equatable/equatable.dart';

import '../../../domain/entities/enum/friend_request_status.dart';
import '../../../domain/entities/friend_request.dart';

class FriendRequestResponse extends Equatable {
  final FriendRequestStatus? status;

  const FriendRequestResponse({required this.status});

  @override
  List<Object?> get props => [status];

  factory FriendRequestResponse.fromMap(Map<String, dynamic> map) {
    final status = FriendRequestStatus.values
        .firstWhere((type) => type.name.toUpperCase() == map['status']);

    return FriendRequestResponse(status: status);
  }

  FriendRequest toEntity() {
    return FriendRequest(status: status);
  }
}
