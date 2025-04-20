
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';

import '../../domain/models/tile.dart';



final entriesProvier = AsyncNotifierProvider.family.autoDispose<EntriesNotifier, EntriesState, String>(
  EntriesNotifier.new,
);

class EntriesNotifier extends AutoDisposeFamilyAsyncNotifier<EntriesState, String> {

  late final _entryRepository = ref.watch(entryRepositoryProvider);
  bool _isBuilding = false;

  @override
  FutureOr<EntriesState> build(String arg) async {
    if (_isBuilding) {
      return state.value ?? EntriesState(page: 1, size: 10,);
    }
    _isBuilding = true;
    logger.i('entries notify build');
    try {
      Future.delayed(Duration(seconds: 3));
      return _fetchEntries(arg, reset: true);
    } catch (e) {
      return state.value?.copyWith(errorMsg: "error") ??
          EntriesState(page: 1, size: 10, errorMsg: "error",);
    } finally {
      _isBuilding = false;
    }
  }

  Future<void> loadMore() async {
    if (!state.value!.hasMore || state.value!.isLoadingMore) return;
    state = AsyncValue.data(state.value!.copyWith(isLoadingMore: true));
    final data = await _fetchEntries(arg);
    state = AsyncValue.data(data);
  }

  Future<EntriesState> _fetchEntries(String pid, {bool reset = false}) async {
    final tile = await ref.watch(tileProvider(pid).future);
    final type = tile.type;
    final id = tile.id;
    final page = reset ? 1 : state.value!.page + 1;
    final pageSize = reset ? 10 : state.value!.size;
    final order = tile.orderx;
    if (tile.id == 0) return EntriesState();

    List<int> feedIds = [];
    List<String> statuses = tile.onlyShowUnread ? ["unread"] : ["unread", "read"];
    DateTime? minTime;
    bool? starred;
    if (type == TileType.feed) {
      feedIds.add(id);
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

    List<Entry> list = await _entryRepository.getEntries(
        page, feedIds: feedIds, size: pageSize, status: statuses,
        order: order, startTime: minTime, starred: starred,
    );
    final newList = reset ? list : [...state.value!.entries, ...list];
    return EntriesState(
      isLoadingMore: false,
      page: page, size: pageSize,
      hasMore: list.length >= pageSize,
      entries: newList,
    );
  }

}

class EntriesState {

  final List<Entry> entries;
  final int page;
  final int size;
  final bool hasMore;
  final bool isLoadingMore;
  final String errorMsg;

  const EntriesState({
    this.entries = const [],
    this.page = 1,
    this.size = 10,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.errorMsg = "",
  });


  EntriesState copyWith({
    List<Entry>? entries,
    int? page,
    int? size,
    bool? isLoadingMore,
    bool? isInitializing,
    bool? hasMore,
    List<int>? feedIds,
    String? errorMsg,
  }) {
    return EntriesState(
      entries: entries ?? this.entries,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

}
