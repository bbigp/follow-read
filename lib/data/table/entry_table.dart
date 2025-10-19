



import 'package:drift/drift.dart';

@DataClassName("EntryRow")
class EntriesTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  Int64Column get feedId => int64().named('feed_id')();

  TextColumn get status => text().named('status')();
  TextColumn get hash => text().named('hash')();
  TextColumn get title => text().named('title')();
  TextColumn get url => text().named('url').withDefault(const Constant(""))();
  TextColumn get content => text().named('content').withDefault(const Constant(""))();
  TextColumn get author => text().named('author').withDefault(const Constant(""))();
  IntColumn get readingTime => integer().named("reading_time")
      .withDefault(const Constant(0))();
  TextColumn get summary => text().named("summary").withDefault(const Constant(""))();
  BoolColumn get starred => boolean().named("starred").withDefault(Constant(false))();
  DateTimeColumn get publishedAt => dateTime().named("published_at").withDefault(Constant(DateTime.now()))();
  DateTimeColumn get createdAt => dateTime().named("created_at").withDefault(Constant(DateTime.now()))();
  DateTimeColumn get changedAt => dateTime().named("changed_at").withDefault(Constant(DateTime.now()))();
  TextColumn get readableContent => text().named("readable_content").withDefault(const Constant(""))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "entries";

}