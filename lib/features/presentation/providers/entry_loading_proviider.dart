



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/ui_item.dart';

import '../../data/repositories/entry_repository.dart';
import 'app_container.dart';




final entriesLoadingProvider = StateNotifierProvider<EntriesLoadingNotifier, EntryListState>((ref) {
  return EntriesLoadingNotifier(entryRepository: ref.watch(entryRepositoryProvider));
});

class EntriesLoadingNotifier extends StateNotifier<EntryListState> {

  final EntryRepository _entryRepository;
  EntriesLoadingNotifier({required EntryRepository entryRepository})
      : _entryRepository = entryRepository, super(EntryListState.empty());

  Future<void> fetchEntry({int? feedId, bool reset = false}) async {
    feedId = feedId ?? state.feedId;
    if (reset) {
      if (state.isInitializing) return;
      state = state.copyWith(
        uiItems: [],
        page: 1, size: 10, feedId: feedId,
        hasMore: true, isLoadingMore: false, isInitializing: true,
      );
      final list = await _entryRepository.getEntries(state.feedId, 1, state.size);
      state = state.copyWith(
          isInitializing: false,
          uiItems: list.map((item) => UiItem(type: ViewType.entryItem, content: item)).toList(),
          hasMore: list.length >= state.size
      );
    } else {
      if (!state.hasMore || state.isLoadingMore) return;
      state = state.copyWith(isLoadingMore: true);
      final nextPage = state.page + 1;
      final list = await _entryRepository.getEntries(state.feedId, nextPage, state.size);
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
  final int feedId;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isInitializing;

  EntryListState({required this.uiItems, required this.page,
    required this.size, required this.hasMore, required this.feedId,
    required this.isLoadingMore, required this.isInitializing,
  });

  factory EntryListState.empty() => EntryListState(
      uiItems: [],
      page: 1, size: 10, feedId: 0,
      hasMore: false, isLoadingMore: false, isInitializing: false,
  );


  EntryListState copyWith({
    List<UiItem>? uiItems,
    int? page,
    int? size,
    bool? hasMore,
    int? feedId,
    bool? isLoadingMore,
    bool? isInitializing,
  }) {
    return EntryListState(
      uiItems: uiItems ?? this.uiItems,
      page: page ?? this.page,
      size: size ?? this.size,
        hasMore: hasMore ?? this.hasMore,
      feedId: feedId ?? this.feedId,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isInitializing: isInitializing ?? this.isInitializing,
    );
  }

}