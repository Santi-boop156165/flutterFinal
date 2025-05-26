import 'dart:typed_data';

class ProfilePictureState {
  final bool loaded;
  final Uint8List? profilePicture;

  const ProfilePictureState(
      {required this.loaded, required this.profilePicture});

  factory ProfilePictureState.initial() {
    return const ProfilePictureState(loaded: false, profilePicture: null);
  }

  ProfilePictureState copyWith({bool? loaded, Uint8List? profilePicture}) {
    return ProfilePictureState(
        loaded: loaded ?? this.loaded,
        profilePicture: profilePicture ?? this.profilePicture);
  }
}
