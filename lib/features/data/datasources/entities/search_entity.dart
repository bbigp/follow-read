

import 'package:drift/drift.dart';

@DataClassName("SearchEntity")
class SearchTable extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().named('word')
      .withDefault(const Constant(""))();
  DateTimeColumn get createdAt => dateTime().named('created_at')
      .withDefault(Constant(DateTime.now()))();

  @override
  String? get tableName => "search";

}