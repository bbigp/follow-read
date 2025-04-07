
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/data/repositories/entry_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';

import '../../domain/models/tile.dart';



class EntryPageValue {
  final AsyncData<EntriesState> entriesState;
  final AsyncValue<Tile> tileState;

  const EntryPageValue({
    required this.entriesState,
    required this.tileState,
  });
}

final entryPageProvider = Provider.autoDispose.family<EntryPageValue, String>((ref, pid){
  final e = ref.watch(entriesProvier(pid));
  final t = ref.watch(tileProvider(pid));
  return EntryPageValue(tileState: t, entriesState: e);
});


final entriesProvier = StateNotifierProvider.autoDispose.family<
    EntriesNotifier, AsyncData<EntriesState>, String>((ref, pid) {
   return EntriesNotifier(ref: ref, pid: pid);
});


class EntriesNotifier extends StateNotifier<AsyncData<EntriesState>> {
  final Ref ref;
  final int id;
  final TileType type;
  final EntryRepository _entryRepository;
  final FeedRepository _feedRepository;

  EntriesNotifier({
    required this.ref,
    required String pid,
  })  : id = PageUtils.parsePid(pid).id,
        type = PageUtils.parsePid(pid).type,
        _entryRepository = ref.watch(entryRepositoryProvider),
        _feedRepository = ref.watch(feedRepositoryProvider),
        super(AsyncData(EntriesState()));

  Future<void> fetchEntries({bool reset = false, bool onlyShowUnread = false}) async {
    final pageSize = state.value.size;
    if (reset) {
      if (state.value.isInitializing) return;
      state = AsyncData(state.value.copyWith(isInitializing: true));
      List<Entry> list = <Entry>[];
      List<int> feedIds = [];
      if (type == TileType.feed) {
        list = await _entryRepository.getEntries(1, feedIds: [id], size: pageSize, onlyShowUnread: onlyShowUnread,);
      }
      if (type == TileType.folder) {
        List<Feed> feeds = await _feedRepository.getFeedsByCategoryId(id);
        feedIds = feeds.map((item) => item.id).toList();
        list = await _entryRepository.getEntries(1, feedIds: feedIds, size: pageSize, onlyShowUnread: onlyShowUnread,);
      }
      final value = state.value.copyWith(
        isInitializing: false, hasMore: list.length >= pageSize,
        entries: list, feedIds: feedIds,
      );
      state = AsyncData(value);
      return;
    }
    if (!state.value.hasMore || state.value.isLoadingMore) return;
    state = AsyncData(state.value.copyWith(isLoadingMore: true));
    final nextPage = state.value.page + 1;

    List<Entry> list = <Entry>[];
    if (type == TileType.feed) {
      list = await _entryRepository.getEntries(nextPage, feedIds: [id], size: pageSize, onlyShowUnread: onlyShowUnread,);
    }
    if (type == TileType.folder) {
      list = await _entryRepository.getEntries(nextPage, feedIds: state.value.feedIds, size: pageSize, onlyShowUnread: onlyShowUnread,);
    }
    final value = state.value.copyWith(
      isLoadingMore: false, hasMore: list.length >= pageSize,
      entries: [...state.value.entries, ...list], page: nextPage,
    );
    state = AsyncData(value);
  }




}

class EntriesState {

  final List<Entry> entries;
  final int page;
  final int size;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isInitializing;
  final List<int> feedIds;

  const EntriesState({
    this.entries = const [],
    this.page = 1,
    this.size = 10,
    this.hasMore = false,
    this.isInitializing = false,
    this.isLoadingMore = false,
    this.feedIds = const [],
  });


  EntriesState copyWith({
    List<Entry>? entries,
    int? page,
    int? size,
    bool? isLoadingMore,
    bool? isInitializing,
    bool? hasMore,
    List<int>? feedIds,
  }) {
    return EntriesState(
      entries: entries ?? this.entries,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isInitializing: isInitializing ?? this.isInitializing,
      hasMore: hasMore ?? this.hasMore,
      feedIds: feedIds ?? this.feedIds,
    );
  }

}
