//
//
// import 'package:drift/drift.dart';
//
// import '../../domain/models/aist.dart';
// import 'database.dart';
// import 'entities/cluster_entity.dart';
//
// @DriftAccessor(tables: [ClustersTable])
// class ClusterDao extends DatabaseAccessor<AppDatabase> {
//
//   ClusterDao(super.db);
//
//   $ClustersTableTable get clusterTable => attachedDatabase.clustersTable;
//
//
//   void save(Cluster c) async {
//     await into(clusterTable).insertOnConflictUpdate(ClustersTableCompanion(
//       id: c.id == 0 ? Value.absent() : Value(c.id),
//       name: Value(c.name), icon: Value(c.icon),
//       feedIds: Value(c.feedIds.join(",")),
//       recentTime: Value(c.recentTime), statuses: Value(c.statuses.join(",")),
//       recentAddTime: Value(c.recentAddTime),
//       deleted: Value(c.deleted),
//       createdAt: c.createdAt == null ? Value(DateTime.now()) : Value(c.createdAt!),
//       changedAt: c.changedAt == null ? Value(DateTime.now()) : Value(c.changedAt!),
//     ));
//   }
//
//   void deleteById(int id) async {
//     var query = delete(clusterTable)..where((r) => r.id.equals(id));
//     await query.go();
//   }
//
//
//   Future<List<ClusterEntity>> getAll({bool showAll = false}) async {
//     var query = select(clusterTable)
//       ..orderBy([(t) => OrderingTerm(expression: clusterTable.id, mode: OrderingMode.asc)]);
//     if (!showAll) {
//       query = query..where((t) => t.hideGlobally.equals(showAll));
//     }
//     return await query.get();
//   }
//
//   Future<ClusterEntity> getById(int id) async {
//     var query = select(clusterTable)..where((t) => t.id.equals(id));
//     return await query.getSingle();
//   }
//
//
//   Future<bool> updateShow(int id, {bool? onlyShowUnread, bool? showReadingTime,
//     String? orderx, bool? hideGlobally, }) async {
//     final affectedRows = await (update(clusterTable)
//       ..where((t) => t.id.equals(id))
//     ).write(
//       ClustersTableCompanion(
//         onlyShowUnread: onlyShowUnread != null
//             ? Value(onlyShowUnread)
//             : const Value.absent(),
//         showReadingTime: showReadingTime != null
//             ? Value(showReadingTime)
//             : const Value.absent(),
//         orderx: orderx != null && orderx != "" ? Value(orderx) : const Value.absent(),
//         hideGlobally: hideGlobally != null ? Value(hideGlobally) : const Value.absent(),
//       ),
//     );
//     return affectedRows > 0;
//   }
//
//
// }