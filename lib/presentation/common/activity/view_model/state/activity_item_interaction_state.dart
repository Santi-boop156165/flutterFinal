class ActivityItemInteractionState {
  final bool displayComments;

  const ActivityItemInteractionState({required this.displayComments});

  factory ActivityItemInteractionState.initial() {
    return const ActivityItemInteractionState(displayComments: false);
  }

  ActivityItemInteractionState copyWith({bool? displayComments}) {
    return ActivityItemInteractionState(
        displayComments: displayComments ?? this.displayComments);
  }
}
