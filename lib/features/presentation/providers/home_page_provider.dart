
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/datasources/category_dao.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/listx.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../data/repositories/category_repository.dart';
import '../../domain/models/feed.dart';

final feedLoadingProvider = StateNotifierProvider<HomePageNotifier, HomePageState>((ref) {
  return HomePageNotifier(
    feedRepository: ref.read(feedRepositoryProvider),
      categoryRepository: ref.read(categoryRepository),
  );
});

class HomePageNotifier extends StateNotifier<HomePageState> {

  final FeedRepository feedRepository;
  final CategoryRepository categoryRepository;

  HomePageNotifier({
    required this.feedRepository,
    required this.categoryRepository,
  }) : super(HomePageState.empty);

  Future<void> loadingData() async{
    final feeds = await feedRepository.getFeeds();
    final Map<int, List<Feed>> feedsMap = feeds.fold<Map<int, List<Feed>>>(
      {}, (map, feed) {
        final cid = feed.categoryId;
        map.putIfAbsent(cid, () => []);
        map[cid]!.add(feed);
        return map;
      },
    );
    final categories = await categoryRepository.getCategories();
    List<Tile> tiles = [];
    for (final category in categories) {
      if (category.title != "all") {
        tiles.add(Tile(type: TileType.folder, id: category.id, title: category.title, feeds: feedsMap[category.id] ?? []));
      }
    }
    final all = categories.firstWhere((c) => c.title == "all");
    for (final feed in feedsMap[all.id] ?? []) {
      tiles.add(Tile(type: TileType.feed, id: feed.id, title: feed.title, feeds: [feed]));
    }
  }

}

class HomePageState {

  final List<Listx> listx;
  final List<Tile> tiles;

  const HomePageState({
    this.tiles = const [],
    this.listx = const <Listx>[],
  });
  static const empty = HomePageState();


}

enum TileType {
  list, feed, folder,
}

class Tile {
  final TileType type;
  final int id;
  final String title;
  final List<Feed> feeds;

  Tile({
    required this.type,
    required this.id,
    this.title = "",
    this.feeds = const [],
  });

}

