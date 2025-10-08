

import 'package:drift/drift.dart';

@DataClassName("SearchHistoryRow")
class SearchHistoryTable extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().named('word').withDefault(const Constant(""))();
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(Constant(DateTime.now()))();
  TextColumn get metaId => text().named("meta_id").withDefault(const Constant(""))();
  Int64Column get userId => int64().named('user_id')();

  @override
  String? get tableName => "search_histories";

}