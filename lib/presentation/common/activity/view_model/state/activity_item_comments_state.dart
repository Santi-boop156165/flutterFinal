import '../../../../../domain/entities/activity_comment.dart';

class ActivityItemCommentsState {
  final bool displayPreviousComments;
  final List<ActivityComment> comments;
  final bool isLoading;

  const ActivityItemCommentsState(
      {required this.displayPreviousComments,
      required this.comments,
      required this.isLoading});

  factory ActivityItemCommentsState.initial() {
    return const ActivityItemCommentsState(
        displayPreviousComments: false, comments: [], isLoading: false);
  }

  ActivityItemCommentsState copyWith(
      {bool? displayPreviousComments,
      List<ActivityComment>? comments,
      bool? isLoading}) {
    return ActivityItemCommentsState(
        displayPreviousComments:
            displayPreviousComments ?? this.displayPreviousComments,
        comments: comments ?? this.comments,
        isLoading: isLoading ?? this.isLoading);
  }
}
