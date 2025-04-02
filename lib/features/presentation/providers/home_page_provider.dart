
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
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
        tiles.add(Tile(type: TileType.folder, id: category.id, title: category.title, feeds: feedsMap[category.id] ?? []));
      }
    }
    final all = categories.firstWhere((c) => c.title == "All");
    for (final feed in feedsMap[all.id] ?? []) {
      tiles.add(Tile(type: TileType.feed, id: feed.id, title: feed.title, feeds: [feed]));
    }
    state = state.copyWith(tiles: tiles);
  }

  void expanded(int id){
    final index = state.tiles.indexWhere((c) => c.id == id);
    if (index == -1) {
      return;
    }
    final newList = List<Tile>.from(state.tiles);
    newList[index] = state.tiles[index].copyWith(expanded: !state.tiles[index].expanded);
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
  final String title;
  final List<Feed> feeds;
  final bool expanded;

  Tile({
    required this.type,
    required this.id,
    this.title = "",
    this.feeds = const [],
    this.expanded = false,
  });

  int get unread {
    return feeds.fold<int>(0, (sum, feed) => sum + feed.unread);
  }

  int get errorCount {
    return type == TileType.folder ? 0 : feeds[0].errorCount;
  }

  Tile copyWith({
    bool? expanded,
    TileType? type,
    int? id,
    String? title,
    List<Feed>? feeds,
  }) {
    return Tile(
      expanded: expanded ?? this.expanded, type: type ?? this.type,
      id: id ?? this.id,
      title: title ?? this.title,
      feeds: feeds ?? this.feeds,
    );
  }

}

