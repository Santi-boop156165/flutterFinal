import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state/infinite_scroll_list_state.dart';

final infiniteScrollListViewModelProvider = StateNotifierProvider.family<
    InfiniteScrollListViewModel,
    InfiniteScrollListState,
    String>((ref, listId) {
  return InfiniteScrollListViewModel(ref, listId);
});

class InfiniteScrollListViewModel
    extends StateNotifier<InfiniteScrollListState> {
  final String listId;
  final Ref ref;

  InfiniteScrollListViewModel(this.ref, this.listId)
      : super(InfiniteScrollListState.initial());

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setData(List<dynamic> data) {
    state = state.copyWith(data: data, pageNumber: state.pageNumber + 1);
  }

  void replaceData(List<dynamic> data) {
    state = state.copyWith(data: data);
  }

  void addData(List<dynamic> data) {
    var currentData = state.data;
    currentData.addAll(data);
    state = state.copyWith(data: currentData, pageNumber: state.pageNumber + 1);
  }

  void setPageNumber(int pageNumber) {
    state = state.copyWith(pageNumber: pageNumber);
  }

  void reset() {
    state = InfiniteScrollListState.initial();
  }
}
