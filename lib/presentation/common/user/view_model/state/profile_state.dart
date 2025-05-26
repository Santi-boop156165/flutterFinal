import 'dart:typed_data';

import '../../../../../domain/entities/enum/friend_request_status.dart';

class ProfileState {
  final bool isLoading; 
  final FriendRequestStatus? friendshipStatus; 
  final Uint8List? profilePicture;

  const ProfileState(
      {required this.isLoading,
      required this.friendshipStatus,
      required this.profilePicture});

  factory ProfileState.initial() {
    return const ProfileState(
        isLoading: false, friendshipStatus: null, profilePicture: null);
  }

  ProfileState copyWith(
      {bool? isLoading,
      FriendRequestStatus? status,
      Uint8List? profilePicture}) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        friendshipStatus: status ?? friendshipStatus,
        profilePicture: profilePicture ?? this.profilePicture);
  }
}
