

import 'package:drift/drift.dart';

@DataClassName("FilterRow")
class FiltersTable extends Table {

  Int64Column get id => int64().named("id").autoIncrement()();
  Int64Column get userId => int64().named('user_id')();
  TextColumn get name => text().named('name')();
  TextColumn get icon => text().named('icon')();
  TextColumn get feedIds => text().named('feed_ids')();
  IntColumn get publishedTime => integer().named("published_time")
      .withDefault(const Constant(0))();
  IntColumn get addTime => integer().named("add_time")
      .withDefault(const Constant(0))();
  TextColumn get statuses => text().named('statuses')();
  DateTimeColumn get createdAt => dateTime().named("created_at")();
  DateTimeColumn get changedAt => dateTime().named("changed_at")();
  TextColumn get orderx => text().named("orderx")
      .withDefault(Constant("published_at"))();
  BoolColumn get hideGlobally => boolean().named("hide_globally")
      .withDefault(Constant(false))();
  BoolColumn get onlyShowUnread => boolean().named('only_show_unread')
      .withDefault(const Constant(false))();
  IntColumn get deleted => integer().named("deleted")
      .withDefault(Constant(0))();

  @override
  String? get tableName => "filters";

}