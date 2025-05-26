import 'dart:typed_data';

class EditProfileState {
  final String firstname;
  final String lastname;
  final Uint8List? profilePicture;
  final bool isEditing;
  final bool errorOnRequest;
  final bool isUploading;

  const EditProfileState(
      {required this.firstname,
      required this.lastname,
      required this.profilePicture,
      required this.isEditing,
      required this.errorOnRequest,
      required this.isUploading});

  factory EditProfileState.initial() {
    return const EditProfileState(
        firstname: '',
        lastname: '',
        profilePicture: null,
        isEditing: false,
        errorOnRequest: false,
        isUploading: false);
  }

  EditProfileState copyWith(
      {String? firstname,
      String? lastname,
      Uint8List? profilePicture,
      bool? isEditing,
      bool? errorOnRequest,
      bool? isUploading}) {
    return EditProfileState(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        profilePicture: profilePicture ?? this.profilePicture,
        isEditing: isEditing ?? this.isEditing,
        errorOnRequest: errorOnRequest ?? this.errorOnRequest,
        isUploading: isUploading ?? this.isUploading);
  }
}
