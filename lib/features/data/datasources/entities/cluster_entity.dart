



import 'package:drift/drift.dart';
import 'package:follow_read/features/domain/models/cluster.dart';

import '../database.dart';

@DataClassName("ClusterEntity")
class ClustersTable extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named("name")();
  TextColumn get icon => text().named("icon")();
  TextColumn get feedIds => text().named("feed_ids")();
  IntColumn get recentTime => integer().named("recent_time")
      .withDefault(Constant(0))();
  TextColumn get statuses => text().named("statuses")
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

extension ClusterEntityConversion on ClusterEntity {
  Cluster toModel(){
    return Cluster(
      id: id, icon: icon, name: name, feedIds: parseFeedIds(feedIds),
      recentTime: recentTime, statuses: parseStatuses(statuses), deleted: deleted,
      createdAt: createdAt, changedAt: changedAt,
    );
  }

  static List<int>parseFeedIds(String str) {
    return str.split(",").where((s) => s.isNotEmpty).map(int.parse).toList();
  }

  static List<String>parseStatuses(String str) {
    return str.split(",");
  }
}