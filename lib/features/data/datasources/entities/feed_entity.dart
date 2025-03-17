
import 'package:drift/drift.dart';
import 'package:follow_read/features/data/datasources/database.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import '../../../domain/models/view_type.dart';

@DataClassName("FeedEntity")
class FeedsTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  TextColumn get feedUrl => text().named('feed_url')();
  TextColumn get siteUrl => text().named('site_url')();
  TextColumn get title => text().named('title')();
  IntColumn get unread => integer().named('unread')
      .withDefault(const Constant(0))();
  IntColumn get read => integer().named('read')
      .withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};

}

extension FeedEntityConversion on FeedEntity {
  Feed toModel() {
    return Feed(
      id: id,
      title: title,
      userId: userId,
      feedUrl: feedUrl,
      siteUrl: siteUrl,
      avatarUrl: "",
      read: read,
      unread: unread,
      viewType: ViewType.feedItem,
    );
  }
}