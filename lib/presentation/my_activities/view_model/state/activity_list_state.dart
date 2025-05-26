class ActivityListState {
  final bool isLoading; 

  const ActivityListState({required this.isLoading});

  factory ActivityListState.initial() {
    return const ActivityListState(isLoading: false);
  }

  ActivityListState copyWith({
    bool? isLoading, 
  }) {
    return ActivityListState(isLoading: isLoading ?? this.isLoading);
  }
}
