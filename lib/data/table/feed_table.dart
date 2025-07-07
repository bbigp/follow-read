

import 'package:drift/drift.dart';

@DataClassName("FeedRow")
class FeedsTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  TextColumn get feedUrl => text().named('feed_url')();
  TextColumn get siteUrl => text().named('site_url')();
  TextColumn get title => text().named('title')();
  TextColumn get iconUrl => text().named('icon_url')
      .withDefault(const Constant(""))();
  IntColumn get errorCount => integer().named("error_count")
      .withDefault(const Constant(0))();
  TextColumn get errorMsg => text().named("error_msg")
      .withDefault(const Constant(""))();
  Int64Column get folderId => int64().named("folder_id")
      .withDefault(Constant(BigInt.zero))();


  BoolColumn get onlyShowUnread => boolean().named('only_show_unread')
      .withDefault(const Constant(false))();

  TextColumn get orderx => text().named("orderx")
      .withDefault(Constant("published_at"))();
  BoolColumn get hideGlobally => boolean().named("hide_globally")
      .withDefault(Constant(false))();
  IntColumn get deleted => integer().named("deleted")
      .withDefault(Constant(0))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "feeds";

}