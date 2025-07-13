//
//
// import 'package:drift/drift.dart';
// import 'package:follow_read/core/utils/logger.dart';
// import 'package:follow_read/modules/pages/entries/meta_data.dart';
//
// import '../../domain/models/constants.dart';
// import 'database.dart';
// import 'entities/entry_entity.dart';
//
// part 'entry_dao.g.dart';
//
// @DriftAccessor(tables: [EntriesTable])
// class EntryDao extends DatabaseAccessor<AppDatabase> with _$EntryDaoMixin {
//   EntryDao(super.db);
//
//
//
//   Future<List<EntryEntity>> getEntriesByFeedId(int feedId) async {
//     return await (select(entriesTable)..where((r) => r.feedId.equals(BigInt.from(feedId)))).get();
//   }
//
//   Future<List<EntryEntity>> fetch(int page, int size, SQLQueryBuilder builder) async {
//     var query = select(entriesTable)..where((t) => entriesTable.status.isIn(builder.statuses));
//     if (builder.feedIds.isNotEmpty){
//       query = query..where((t) => t.feedId.isIn(builder.feedIds.map((i) => BigInt.from(i)).toList()));
//     }
//     if (builder.starred != null) {
//       query = query..where((t) => t.starred.equals(true));
//     }
//     if (builder.minPublishedTime != null) {
//       query = query..where((t) => t.publishedAt.isBiggerOrEqualValue(builder.minPublishedTime!));
//     }
//     if (builder.minAddTime != null) {
//       query = query..where((t) => t.createdAt.isBiggerOrEqualValue(builder.minAddTime!));
//     }
//     if (builder.word.isNotEmpty) {
//       final keyword = '%${builder.word}%';
//       query = query..where((t) => t.title.like(keyword) | t.content.like(keyword) | t.summary.like(keyword));
//     }
//
//     final orderByColumn = switch(builder.order) {
//       Model.orderxCreatedAt => entriesTable.createdAt,
//       _ => entriesTable.publishedAt,
//     };
//
//     // final ordering = direction.toLowerCase() == 'asc'
//     //     ? OrderingMode.asc
//     //     : OrderingMode.desc;
//
//     query..orderBy([(t) => OrderingTerm(expression: orderByColumn, mode: OrderingMode.desc)])
//       ..limit(size, offset: (page - 1) * size);
//
//     return await query.get();
//   }
//

//
//   Future<List<EntryEntity>> getAllEntries() async {
//     return await select(entriesTable).get();
//   }
//
//   Future<List<EntryEntity>> getAllEntriesByIds(List<int> ids) async {
//     if (ids.isEmpty) return [];
//     return await (select(entriesTable)..where((t) => t.id.isIn(ids.map((e) => BigInt.from(e)).toList()))).get();
//   }
//
//   Future<EntryEntity?> getEntry(int entryId) async {
//     return await (select(entriesTable)..where((t) => t.id.equals(BigInt.from(entryId)))).getSingleOrNull();
//   }
//
//   Future<bool> updateStatus(int entryId, {String? status, bool? starred}) async {
//     final affectedRows = await (update(entriesTable)
//       ..where((t) => t.id.equals(BigInt.from(entryId)))
//     ).write(
//       EntriesTableCompanion(
//         status: status != null ? Value(status) : const Value.absent(),
//         starred: starred != null ? Value(starred) : const Value.absent(),
//       )
//     );
//     return affectedRows > 0;
//   }
//
//   Future<DateTime?> getMaxChangedAt() async {
//     final query = selectOnly(entriesTable);
//     final maxChangedAt = entriesTable.changedAt.max();
//     query.addColumns([maxChangedAt]);
//     final result = await query.getSingleOrNull();
//     return result?.read(maxChangedAt);
//   }
//

//
//   Future<bool> deleteByFeedId(int feedId) async {
//     var query = delete(entriesTable)..where((f) => f.feedId.equals(BigInt.from(feedId)));
//     var affectedRows = await query.go();
//     return affectedRows > 0;
//   }
//
// }