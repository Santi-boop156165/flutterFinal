class ActivityItemLikeState {
  final double likes;
  final bool hasUserLiked;

  const ActivityItemLikeState(
      {required this.likes, required this.hasUserLiked});

  factory ActivityItemLikeState.initial() {
    return const ActivityItemLikeState(likes: 0, hasUserLiked: false);
  }

  ActivityItemLikeState copyWith({double? likes, bool? hasUserLiked}) {
    return ActivityItemLikeState(
        likes: likes ?? this.likes,
        hasUserLiked: hasUserLiked ?? this.hasUserLiked);
  }
}
