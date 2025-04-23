
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/data/repositories/cluster_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/user_provider.dart';

import '../../data/datasources/entry_dao.dart';
import '../../data/repositories/category_repository.dart';
import '../../domain/models/feed.dart';
import '../../domain/models/tile.dart';


final homePageProvider = AsyncNotifierProvider.autoDispose<HomeNotifier, HomePageValue>(
  HomeNotifier.new,
);

class HomeNotifier extends AutoDisposeAsyncNotifier<HomePageValue> {

  late final FeedRepository _feedRepository = ref.watch(feedRepositoryProvider);
  late final CategoryRepository _categoryRepository = ref.watch(categoryRepositoryProvider);
  late final EntryDao _entryDao = ref.watch(entryDaoProvider);
  late final ClusterRepository _clusterRepository = ref.watch(clusterRepositoryProvider);

  @override
  FutureOr<HomePageValue> build() async {
    logger.i('初始化home notifier');
    bool showAll = await ref.watch(showAllProvider);
    bool? hideGlobally = showAll ? null : false;

    var tiles = await loadingTiles(hideGlobally);
    var clusters = await _clusterRepository.getAll(hideGlobally: hideGlobally);
    return HomePageValue(tiles: tiles, clusters: clusters);
  }

  Future<List<Tile>> loadingTiles(bool? hideGlobally) async{
    final feeds = await _feedRepository.getFeeds(hideGlobally: hideGlobally);
    final Map<int, List<Feed>> feedsMap = feeds.fold<Map<int, List<Feed>>>(
      {}, (map, feed) {
        final cid = feed.categoryId;
        map.putIfAbsent(cid, () => []);
        map[cid]!.add(feed);
        return map;
      },
    );
    final categories = await _categoryRepository.getCategories(hideGlobally: hideGlobally);
    List<Tile> tiles = [];
    for (final category in categories) {
      if (category.title != "All") {
        tiles.add(Tile(type: TileType.folder, category: category, feeds: feedsMap[category.id] ?? []));
      }
    }
    final all = categories.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
    for (final feed in feedsMap[all.id] ?? []) {
      tiles.add(Tile(type: TileType.feed, feed: feed));
    }
    return tiles;
  }

  void expanded(int id){
    final index = state.value!.tiles.indexWhere((c) => c.type == TileType.folder && c.category.id == id);
    if (index == -1) {
      return;
    }
    final newList = List<Tile>.from(state.value!.tiles);
    final tile = state.value!.tiles[index];
    newList[index] = tile.copyWith(expanded: !tile.expanded);
    state = AsyncData(state.value!.copyWith(tiles: newList));
  }

}

class HomePageValue {

  final List<Cluster> clusters;
  final List<Tile> tiles;

  const HomePageValue({
    this.tiles = const [],
    this.clusters = const <Cluster>[],
  });
  static const empty = HomePageValue();

  HomePageValue copyWith({
    List<Tile>? tiles,
    List<Cluster>? clusters,
  }) {
    return HomePageValue(
      tiles: tiles ?? this.tiles,
      clusters: clusters ?? this.clusters,
    );
  }

}
