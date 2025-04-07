

import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/listx.dart';


class Tile {

  final TileType type;
  final Feed feed;
  final Category category;
  final List<Feed> feeds;
  final bool expanded;
  final Listx listx;

  const Tile({
    this.feed = const Feed(id: 0, userId: 0, feedUrl: "", siteUrl: "", title: ""),
    this.category = const Category(id: 0, title: ""),
    this.feeds = const [],
    this.type = TileType.none,
    this.expanded = false,
    this.listx = const Listx(id: 0, title: "", svgicon: ""),
  });

  Tile copyWith({
    Feed? feed,
    Category? category,
    List<Feed>? feeds,
    TileType? type,
    bool? expanded,
    Listx? listx,
  }) {
    return Tile(
      feed: feed ?? this.feed,
      category: category ?? this.category,
      feeds: feeds ?? this.feeds,
      type: type ?? this.type,
      expanded: expanded ?? this.expanded,
      listx: listx ?? this.listx,
    );
  }

  static Tile empty = Tile();

  int get id {
    if (type == TileType.feed) return feed.id;
    if (type == TileType.folder) return category.id;
    if (type == TileType.list) return listx.id;
    return 0;
  }

  String get title {
    if (type == TileType.feed) return feed.title;
    if (type == TileType.folder) return category.title;
    if (type == TileType.list) return listx.title;
    return "";
  }

  String get feedUrl {
    if (type == TileType.feed) return feed.feedUrl;
    return "";
  }

  String get iconUrl {
    if (type == TileType.feed) return feed.iconUrl;
    return "";
  }

  int get unread {
    if (type == TileType.feed) return feed.unread;
    if (type == TileType.folder) return feeds.fold<int>(0, (sum, feed) => sum + feed.unread);
    if (type == TileType.list) return listx.count;
    return 0;
  }

  int get errorCount {
    if (type == TileType.feed) return feed.errorCount;
    if (type == TileType.folder) return feeds.fold<int>(0, (sum, feed) => sum + feed.errorCount);
    return 0;
  }

  bool get onlyShowUnread {
    if (type == TileType.feed) return feed.onlyShowUnread;
    if (type == TileType.folder) return category.onlyShowUnread;
    return false;
  }

  bool get showReadingTime {
    if (type == TileType.feed) return feed.showReadingTime;
    if (type == TileType.folder) return category.showReadingTime;
    return false;
  }

}

enum TileType {
  list, feed, folder, none;

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