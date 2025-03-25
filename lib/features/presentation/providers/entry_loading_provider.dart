



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/ui_item.dart';

import '../../data/repositories/entry_repository.dart';
import 'app_container.dart';



final entriesLoadingProvider = StateNotifierProvider.autoDispose.family<EntriesLoadingNotifier, EntryListState, int>((ref, feedId) {
  return EntriesLoadingNotifier(feedId: feedId, repository: ref.watch(entryRepositoryProvider));
});

class EntriesLoadingNotifier extends StateNotifier<EntryListState> {

  final EntryRepository repository;
  final int feedId;
  EntriesLoadingNotifier({required this.repository, required this.feedId})
      : super(EntryListState.empty()) {
  }

  Future<void> fetchEntries({bool reset = false, bool onlyShowUnread = false}) async {
    if (reset) {
      if (state.isInitializing) return;
      state = state.copyWith(
        uiItems: [],
        page: 1, size: 10,
        hasMore: true, isLoadingMore: false, isInitializing: true,
      );
      final list = await repository.getEntries(feedId, 1, state.size, onlyShowUnread: onlyShowUnread,);
      // final list = await repository.getEntriesByFeedId(feedId);
      state = state.copyWith(
          isInitializing: false,
          uiItems: list.map((item) => UiItem(type: ViewType.entryItem, content: item)).toList(),
          hasMore: list.length >= state.size
      );
    } else {
      if (!state.hasMore || state.isLoadingMore) return;
      state = state.copyWith(isLoadingMore: true);
      final nextPage = state.page + 1;
      final list = await repository.getEntries(feedId, nextPage, state.size, onlyShowUnread: onlyShowUnread,);
      final allFeeds = [...state.uiItems, ...list.map((item) => UiItem(type: ViewType.entryItem, content: item))];
      state = state.copyWith(
          isLoadingMore: false,
          uiItems: allFeeds,
          hasMore: list.length >= state.size, page: nextPage
      );
    }
  }


}


class EntryListState {
  final List<UiItem> uiItems;
  final int page;
  final int size;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isInitializing;

  EntryListState({required this.uiItems, required this.page,
    required this.size, required this.hasMore,
    required this.isLoadingMore, required this.isInitializing,
  });

  factory EntryListState.empty() => EntryListState(
      uiItems: [],
      page: 1, size: 10,
      hasMore: false, isLoadingMore: false, isInitializing: false,
  );


  EntryListState copyWith({
    List<UiItem>? uiItems,
    int? page,
    int? size,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isInitializing,
  }) {
    return EntryListState(
      uiItems: uiItems ?? this.uiItems,
      page: page ?? this.page,
      size: size ?? this.size,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isInitializing: isInitializing ?? this.isInitializing,
    );
  }

}