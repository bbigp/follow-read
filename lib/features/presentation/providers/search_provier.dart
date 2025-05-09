

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';

import '../../domain/models/entry.dart';


final searchProvier = AsyncNotifierProvider.family.autoDispose<SearchNotifier, SearchState, String>(
  SearchNotifier.new,
);

class SearchNotifier extends AutoDisposeFamilyAsyncNotifier<SearchState, String> {

  late final _entryRepository = ref.watch(entryRepositoryProvider);
  late final _searchDao = ref.watch(searchDaoProvider);

  @override
  FutureOr<SearchState> build(String arg) async {
    final tile = await ref.watch(tileProvider(arg).future);
    List<String> histories = await _searchDao.getAll();
    return SearchState(tile: tile, histories: histories);
  }

  Future<void> search(String word) async {
    state = AsyncValue.data(state.value!.copyWith(word: word, isInitializing: true));
    _searchDao.save(word);
    final tile = state.value!.tile;
    int page = 1;
    int size = 10;
    final order = tile.orderx;
    final type = tile.type;

    List<int> feedIds = [];
    List<String> statuses = tile.onlyShowUnread ? ["unread"] : ["unread", "read"];
    DateTime? minTime;
    bool? starred;
    if (type == TileType.feed) {
      feedIds.add(tile.id);
    }
    if (type == TileType.folder) {
      feedIds.addAll(tile.feeds.map((item) => item.id).toList());
    }
    if (type == TileType.cluster) {
      feedIds.addAll(tile.cluster.feedIds);//feed hide针对list不生效
      if (tile.cluster.statuses.isNotEmpty) {
        statuses = tile.cluster.statuses;
      }
      if (tile.cluster.recentTime > 0) {
        minTime = DateTime.now().add(Duration(minutes: -tile.cluster.recentTime));
      }
      starred = switch(tile.cluster.starred) {
        1 => true,
        0 => false,
        _ => null
      };
    }

    final list = await _entryRepository.getEntries(
      page, feedIds: feedIds, size: size, status: statuses,
      order: order, starred: starred, minPublishedTime: minTime,
      word: word,
    );

    var newList = List<String>.from(state.value!.histories);
    newList.insert(0, word);

    state = AsyncData(state.value!.copyWith(
      isInitializing: false, page: page, size: size, hasMore: list.length >= size,
      entries: list, histories: newList.toSet().toList(),
    ));
  }

  Future<void> loadMore() async {
    state = AsyncValue.data(state.value!.copyWith(isLoadingMore: true));
    final tile = state.value!.tile;
    int page = state.value!.page + 1;
    int size = state.value!.size;
    final order = tile.orderx;
    String word = state.value!.word;
    final type = tile.type;

    List<int> feedIds = [];
    List<String> statuses = tile.onlyShowUnread ? ["unread"] : ["unread", "read"];
    DateTime? minTime;
    bool? starred;
    if (type == TileType.feed) {
      feedIds.add(tile.id);
    }
    if (type == TileType.folder) {
      feedIds.addAll(tile.feeds.map((item) => item.id).toList());
    }
    if (type == TileType.cluster) {
      feedIds.addAll(tile.cluster.feedIds);//feed hide针对list不生效
      if (tile.cluster.statuses.isNotEmpty) {
        statuses = tile.cluster.statuses;
      }
      if (tile.cluster.recentTime > 0) {
        minTime = DateTime.now().add(Duration(minutes: -tile.cluster.recentTime));
      }
      starred = switch(tile.cluster.starred) {
        1 => true,
        0 => false,
        _ => null
      };
    }


    final list = await _entryRepository.getEntries(
      page, feedIds: feedIds, size: size, status: statuses,
      order: order, starred: starred, minPublishedTime: minTime,
      word: word,
    );

    final newList = [...state.value!.entries, ...list];
    state = AsyncData(state.value!.copyWith(
      isLoadingMore: false, page: page, size: size, hasMore: list.length >= size,
      entries: newList,
    ));
  }


  void clearSearchResult(){
    state = AsyncData(state.value!.copyWith(word: ""));
  }

  void clearSearchHistory() {
    _searchDao.deleteData();
    state = AsyncData(state.value!.copyWith(histories: []));
  }

}


class SearchState {

  final List<Entry> entries;
  final int page;
  final int size;
  final bool hasMore;
  final bool isInitializing;
  final bool isLoadingMore;
  final String errorMsg;
  final Tile tile;
  final List<String> histories;
  final String word;

  const SearchState({
    this.entries = const [],
    this.page = 1,
    this.size = 10,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.errorMsg = "",
    this.tile = const Tile(),
    this.histories = const [],
    this.isInitializing = false,
    this.word = "",
  });


  SearchState copyWith({
    List<Entry>? entries,
    int? page,
    int? size,
    bool? isLoadingMore,
    bool? hasMore,
    List<int>? feedIds,
    String? errorMsg,
    Tile? tile,
    List<String>? histories,
    bool? isInitializing,
    String? word,
  }) {
    return SearchState(
      entries: entries ?? this.entries,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMsg: errorMsg ?? this.errorMsg,
      tile: tile ?? this.tile,
      histories: histories ?? this.histories,
      isInitializing: isInitializing ?? this.isInitializing,
      word: word ?? this.word,
    );
  }

}