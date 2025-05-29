

import 'package:follow_read/features/domain/cases/base.dart';

import 'constants.dart';
import 'feed.dart';

class Category implements MetaViewData{

  final int id;
  @override
  final String title;
  final int userId;
  final bool hideGlobally;
  final bool onlyShowUnread;
  final bool showReadingTime;
  final String order;


  final List<Feed> feeds;
  final bool expanded;

  const Category({
    required this.id,
    required this.title,
    this.userId = 0,
    this.hideGlobally = false,
    this.onlyShowUnread = false,
    this.showReadingTime = false,
    this.order = Frc.orderxPublishedAt,
    this.feeds = const [],
    this.expanded = false,
  });

  static Category empty = Category(id: 0, title: "",);

  bool get isEmpty {
    return id == 0;
  }

  // int get unread {
  //   return feeds.fold<int>(0, (sum, feed) => sum + feed.unread);
  // }
  //
  // int get errorCount {
  //   return feeds.fold<int>(0, (sum, feed) => sum + feed.errorCount);
  // }


  Category copyWith({
    int? id,
    String? title,
    int? userId,
    bool? hideGlobally,
    bool? onlyShowUnread,
    bool? showReadingTime,
    String? order,
    List<Feed>? feeds,
    bool? expanded,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      showReadingTime: showReadingTime ?? this.showReadingTime,
      order: order ?? this.order,
      feeds: feeds ?? this.feeds,
      expanded: expanded ?? this.expanded,
    );
  }

  @override
  int get unread => feeds.fold<int>(0, (sum, feed) => sum + feed.unread);

  @override
  SQLQueryBuilder toBuilder() {
    // TODO: implement toBuilder
    throw UnimplementedError();
  }

}