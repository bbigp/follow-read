



import 'package:drift/drift.dart';

@DataClassName("ClusterEntity")
class ClustersTable extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named("name")();
  TextColumn get icon => text().named("icon")();
  TextColumn get feedIds => text().named("feed_ids")();
  IntColumn get recentTime => integer().named("recent_time")
      .withDefault(Constant(0))();
  TextColumn get status => text().named("status")
      .withDefault(Constant(""))();

  IntColumn get deleted => integer().named("deleted")
      .withDefault(Constant(0))();
  DateTimeColumn get createdAt => dateTime().named('created_at')
      .withDefault(Constant(DateTime.now()))();
  DateTimeColumn get changedAt => dateTime().named('changed_at')
      .withDefault(Constant(DateTime.now()))();

  @override
  String? get tableName => "clusters";

}