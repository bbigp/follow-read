
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/listx.dart';
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
  late final CategoryRepository _categoryRepository = ref.watch(categoryRepository);
  late final EntryDao _entryDao = ref.watch(entryDaoProvider);

  @override
  FutureOr<HomePageValue> build() async {
    logger.i('初始化home notifier');
    bool showAll = await ref.watch(showAllProvider);
    bool? hideGlobally = showAll ? null : false;

    var tiles = await loadingTiles(hideGlobally);
    var listx = await list();
    return HomePageValue(tiles: tiles, listx: listx);
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

  Future<List<Listx>> list() async {
    final smartCount = await _entryDao.countSmartList();
    return [
      Listx.allListx.copyWith(count: smartCount.total),
      Listx.readListx.copyWith(count: smartCount.read),
      Listx.starredListx.copyWith(count: smartCount.starred),
      Listx.unreadListx.copyWith(count: smartCount.unread),
      Listx.todayListx.copyWith(count: smartCount.today),
    ];
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

  final List<Listx> listx;
  final List<Tile> tiles;

  const HomePageValue({
    this.tiles = const [],
    this.listx = const <Listx>[],
  });
  static const empty = HomePageValue();

  HomePageValue copyWith({
    List<Tile>? tiles,
    List<Listx>? listx,
  }) {
    return HomePageValue(
      tiles: tiles ?? this.tiles,
        listx: listx ?? this.listx,
    );
  }

}
