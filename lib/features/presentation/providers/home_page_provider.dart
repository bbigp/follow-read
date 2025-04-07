
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/listx.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../data/repositories/category_repository.dart';
import '../../domain/models/feed.dart';
import '../../domain/models/tile.dart';

final homePageProvider = StateNotifierProvider.autoDispose<
    HomePageNotifier, AsyncValue<HomePageValue>>((ref) {
  return HomePageNotifier(ref: ref,);
});

class HomePageNotifier extends StateNotifier<AsyncValue<HomePageValue>> {

  final FeedRepository _feedRepository;
  final CategoryRepository _categoryRepository;
  final Ref ref;

  HomePageNotifier({required this.ref,})
      : _feedRepository = ref.watch(feedRepositoryProvider),
        _categoryRepository = ref.watch(categoryRepository),
        super(AsyncValue.loading());

  Future<void> loadingData() async{
    final feeds = await _feedRepository.getFeeds();
    final Map<int, List<Feed>> feedsMap = feeds.fold<Map<int, List<Feed>>>(
      {}, (map, feed) {
        final cid = feed.categoryId;
        map.putIfAbsent(cid, () => []);
        map[cid]!.add(feed);
        return map;
      },
    );
    final categories = await _categoryRepository.getCategories();
    List<Tile> tiles = [];
    for (final category in categories) {
      if (category.title != "All") {
        tiles.add(Tile(type: TileType.folder, category: category, feeds: feedsMap[category.id] ?? []));
      }
    }
    final all = categories.firstWhere((c) => c.title == "All");
    for (final feed in feedsMap[all.id] ?? []) {
      tiles.add(Tile(type: TileType.feed, feed: feed));
    }
    state = AsyncData(HomePageValue(tiles: tiles));
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
    List<Tile>? tiles
  }) {
    return HomePageValue(
      tiles: tiles ?? this.tiles,
    );
  }

}
