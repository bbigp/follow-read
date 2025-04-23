

import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/domain/models/feed.dart';



class Tile {

  final TileType type;
  final Feed feed;
  final Category category;
  final List<Feed> feeds;
  final bool expanded;
  final Cluster cluster;

  const Tile({
    this.feed = const Feed(id: 0, userId: 0, feedUrl: "", siteUrl: "", title: ""),
    this.category = const Category(id: 0, title: ""),
    this.feeds = const [],
    this.type = TileType.none,
    this.expanded = false,
    this.cluster = const Cluster(),
  });

  Tile copyWith({
    Feed? feed,
    Category? category,
    List<Feed>? feeds,
    TileType? type,
    bool? expanded,
    Cluster? cluster,
  }) {
    return Tile(
      feed: feed ?? this.feed,
      category: category ?? this.category,
      feeds: feeds ?? this.feeds,
      type: type ?? this.type,
      expanded: expanded ?? this.expanded,
      cluster: cluster ?? this.cluster,
    );
  }

  static Tile empty = Tile();

  int get id {
    if (type == TileType.feed) return feed.id;
    if (type == TileType.folder) return category.id;
    if (type == TileType.cluster) return cluster.id;
    return 0;
  }

  bool get hideGlobally {
    if (type == TileType.feed) return feed.hideGlobally;
    if (type == TileType.folder) return category.hideGlobally;
    if (type == TileType.cluster) return cluster.hideGlobally;
    return false;
  }

  String get title {
    if (type == TileType.feed) return feed.title;
    if (type == TileType.folder) return category.title;
    if (type == TileType.cluster) return cluster.name;
    return "";
  }

  String get orderx {
    if (type == TileType.feed) return feed.order;
    if (type == TileType.folder) return category.order;
    if (type == TileType.cluster) return cluster.order;
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
    if (type == TileType.cluster) return cluster.count;
    return 0;
  }

  int get errorCount {
    if (type == TileType.feed) return feed.errorCount;
    if (type == TileType.folder) return feeds.fold<int>(0, (sum, feed) => sum + feed.errorCount);
    return 0;
  }

  String get errorMsg {
    if (type == TileType.feed) return feed.errorMsg;
    return '';
  }

  bool get onlyShowUnread {
    if (type == TileType.feed) return feed.onlyShowUnread;
    if (type == TileType.folder) return category.onlyShowUnread;
    if (type == TileType.cluster) return cluster.onlyShowUnread;
    return false;
  }

  bool get showReadingTime {
    if (type == TileType.feed) return feed.showReadingTime;
    if (type == TileType.folder) return category.showReadingTime;
    if (type == TileType.cluster) return cluster.showReadingTime;
    return false;
  }

}

enum TileType {
  cluster, feed, folder, none;

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