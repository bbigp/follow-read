



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/ui_item.dart';

import '../../data/repositories/entry_repository.dart';
import 'app_container.dart';



final entriesLoadingProvider = StateNotifierProvider.autoDispose.family<
    EntriesLoadingNotifier, AsyncValue<EntryListState>, int>((ref, feedId) {
  return EntriesLoadingNotifier(
      feedId: feedId, repository: ref.watch(entryRepositoryProvider),
  );
});

class EntriesLoadingNotifier extends StateNotifier<AsyncValue<EntryListState>> {

  final EntryRepository repository;
  final int feedId;
  EntriesLoadingNotifier({required this.repository, required this.feedId})
      : super(AsyncValue.data(EntryListState(uiItems: [], page: 1, size: 10,
      isLoadingMore: false, isInitializing: false, hasMore: false)));

  Future<void> fetchEntries({bool reset = false, bool onlyShowUnread = false}) async {
    final pageSize = state.value!.size;
    if (reset) {
      if (state.value!.isInitializing) return;
      state = AsyncData(state.value!.copyWith(isInitializing: true));
      final list = await repository.getEntries(feedId, 1, size: pageSize, onlyShowUnread: onlyShowUnread,);
      // final list = await repository.getEntriesByFeedId(feedId);
      final value = state.value?.copyWith(
        isInitializing: false, hasMore: list.length >= pageSize,
        uiItems: list.map((item) => UiItem(type: ViewType.entryItem, content: item)).toList(),
      );
      state = AsyncValue.data(value!);
    } else {
      if (!state.value!.hasMore || state.value!.isLoadingMore) return;
      state = AsyncData(state.value!.copyWith(isLoadingMore: true));
      final nextPage = state.value!.page + 1;
      final list = await repository.getEntries(feedId, nextPage, size: pageSize, onlyShowUnread: onlyShowUnread,);
      final allFeeds = [...state.value!.uiItems, ...list.map((item) => UiItem(type: ViewType.entryItem, content: item))];
      state = AsyncData(state.value!.copyWith(
          isLoadingMore: false,
          uiItems: allFeeds,
          page: nextPage,
          hasMore: list.length >= pageSize,
      ));
    }
  }

  Future<void> updateRead(int entryId, String status) async {
    final index = state.value!.uiItems.indexWhere((item){
      if (item.type != ViewType.entryItem) {
        return false;
      }
      return (item.content as Entry).id == entryId;
    });
    if (index == -1) {
      return;
    }
    final newList = List<UiItem>.from(state.value!.uiItems);
    newList[index] = UiItem(type: ViewType.entryItem, content: (state.value!.uiItems[index].content as Entry).copyWith(status: status));
    state = AsyncData(state.value!.copyWith(uiItems: newList));
  }


}


class EntryListState {
  final List<UiItem> uiItems;
  final int page;
  final int size;
  final bool isLoadingMore;
  final bool isInitializing;
  final bool hasMore;

  EntryListState({required this.uiItems, required this.page,
    required this.size, required this.hasMore,
    required this.isLoadingMore, required this.isInitializing,
  });

  factory EntryListState.empty() => EntryListState(
      uiItems: [],
      page: 1, size: 10, hasMore: false,
      isLoadingMore: false, isInitializing: false,
  );


  EntryListState copyWith({
    List<UiItem>? uiItems,
    int? page,
    int? size,
    bool? isLoadingMore,
    bool? isInitializing,
    bool? hasMore,
  }) {
    return EntryListState(
      uiItems: uiItems ?? this.uiItems,
      page: page ?? this.page,
      size: size ?? this.size,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isInitializing: isInitializing ?? this.isInitializing,
      hasMore: hasMore ?? this.hasMore,
    );
  }

}