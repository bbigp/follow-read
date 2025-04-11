
import 'package:drift/drift.dart';
import 'package:follow_read/features/data/datasources/database.dart';
import 'package:follow_read/features/domain/models/feed.dart';


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
  TextColumn get iconUrl => text().named('icon_url')
    .withDefault(const Constant(""))();

  BoolColumn get onlyShowUnread => boolean().named('only_show_unread')
      .withDefault(const Constant(false))();
  BoolColumn get showReadingTime => boolean().named('show_reading_time')
      .withDefault(const Constant(false))();

  IntColumn get errorCount => integer().named("error_count")
      .withDefault(const Constant(0))();
  TextColumn get errorMsg => text().named("error_msg")
      .withDefault(const Constant(""))();
  Int64Column get categoryId => int64().named("category_id")
      .withDefault(Constant(BigInt.zero))();
  TextColumn get orderx => text().named("orderx")
      .withDefault(Constant("published_at"))();
  BoolColumn get hideGlobally => boolean().named("hide_globally")
    .withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "feeds";

}

extension FeedEntityConversion on FeedEntity {
  Feed toModel() {
    return Feed(
      id: id.toInt(),
      title: title,
      userId: userId.toInt(),
      feedUrl: feedUrl,
      siteUrl: siteUrl,
      read: read,
      unread: unread,
      iconUrl: iconUrl,
      onlyShowUnread: onlyShowUnread,
      showReadingTime: showReadingTime,
      errorMsg: errorMsg,
      errorCount: errorCount,
      categoryId: categoryId.toInt(),
      orderx: orderx,
      hideGlobally: hideGlobally,
    );
  }
}