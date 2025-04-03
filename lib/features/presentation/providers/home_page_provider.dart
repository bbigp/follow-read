
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/listx.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../data/repositories/category_repository.dart';
import '../../domain/models/feed.dart';

final homeLoadingProvider = StateNotifierProvider<HomePageNotifier, HomePageState>((ref) {
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
      if (category.title != "All") {
        tiles.add(Tile(type: TileType.folder, id: category.id,
            category: category.copyWith(feeds: feedsMap[category.id] ?? []),
        ));
      }
    }
    final all = categories.firstWhere((c) => c.title == "All");
    for (final feed in feedsMap[all.id] ?? []) {
      tiles.add(Tile(type: TileType.feed, id: feed.id, feed: feed));
    }
    state = state.copyWith(tiles: tiles);
  }

  void expanded(int id){
    final index = state.tiles.indexWhere((c) => c.id == id && c.type == TileType.folder);
    if (index == -1) {
      return;
    }
    final c = state.tiles[index].category.copyWith(expanded: !state.tiles[index].category.expanded);
    final newList = List<Tile>.from(state.tiles);
    newList[index] = state.tiles[index].copyWith(category: c);
    state = state.copyWith(tiles: newList);
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

  HomePageState copyWith({
    List<Tile>? tiles
  }) {
    return HomePageState(
      tiles: tiles ?? this.tiles,
    );
  }

}

enum TileType {
  list, feed, folder;

  @override
  String toString() => name;

  static TileType fromString(String value) {
    try {
      return TileType.values.byName(value);
    } catch (_) {
      return feed;
    }
  }
}

class Tile {
  final TileType type;
  final int id;
  final Category category;
  final Feed feed;


  const Tile({
    required this.type,
    required this.id,
    this.feed = const Feed(id: 0, userId: 0, feedUrl: "", siteUrl: "", title: ""),
    this.category= const Category(id: 0, title: ""),
  });


  int get unread {
    if (type == TileType.feed) {
      return feed.unread;
    }
    if (type == TileType.folder) {
      return category.unread;
    }
    return 0;
  }

  int get errorCount {
    if (type == TileType.feed) {
      return feed.errorCount;
    }
    if (type == TileType.folder) {
      return category.errorCount;
    }
    return 0;
  }

  Tile copyWith({
    TileType? type,
    int? id,
    Feed? feed,
    Category? category,
  }) {
    return Tile(
      id: id ?? this.id,
      feed: feed ?? this.feed,
      category: category ?? this.category,
      type: type ?? this.type,
    );
  }

}

