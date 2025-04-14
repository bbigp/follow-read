
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
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
    if (type == TileType.feed) {
      feedIds.add(id);
    }
    if (type == TileType.folder) {
      feedIds.addAll(tile.feeds.map((item) => item.id).toList());
    }
    if (type == TileType.cluster) {
      feedIds.addAll(tile.cluster.feedIds);
    }

    List<Entry> list = <Entry>[];
    if (type == TileType.feed || type == TileType.folder) {
      list = await _entryRepository.getEntries(
        page, feedIds: [id], size: pageSize, status: statuses,
        orderx: order,
      );
    } else if (type == TileType.cluster) {
      list = await _getListx(tile.cluster, page, pageSize);
    }
    final newList = reset ? list : [...state.value!.entries, ...list];
    return EntriesState(
      isLoadingMore: false,
      page: page, size: pageSize,
      hasMore: list.length >= pageSize,
      entries: newList,
    );
  }

  Future<List<Entry>>  _getListx(Cluster cluster, int page, int pageSize) async {
    List<String> status = cluster.statuses;
    bool? starred;
    DateTime? startTime;
    return await _entryRepository.getEntries(feedIds: cluster.feedIds ?? [], page, size: pageSize,
        status: status, starred: starred, startTime: startTime);
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
