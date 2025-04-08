

import 'package:drift/drift.dart';
import 'package:follow_read/features/domain/models/smart_list_count.dart';

import '../../domain/models/constants.dart';
import 'database.dart';
import 'entities/entry_entity.dart';

part 'entry_dao.g.dart';

@DriftAccessor(tables: [EntriesTable])
class EntryDao extends DatabaseAccessor<AppDatabase> with _$EntryDaoMixin {
  EntryDao(super.db);


  Future<void> bulkInsertWithTransaction(List<EntriesTableCompanion> entries) async {
    if (entries.isEmpty) {
      return;
    }
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(
          entriesTable,
          entries,
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<EntryEntity>> getEntriesByFeedId(int feedId) async {
    return await (select(entriesTable)..where((r) => r.feedId.equals(BigInt.from(feedId)))).get();
  }

  Future<List<EntryEntity>> paginateEntries({
    List<int> feedIds = const[],
    int page = 1,
    int size = 20, List<String> status = const ['unread'],
    String? orderx, String direction = "desc",
    bool? starred, DateTime? startTime,
  }) async {
    var query = select(entriesTable)..where((t) => entriesTable.status.isIn(status));
    if (feedIds.isNotEmpty){
      query = query..where((t) => t.feedId.isIn(feedIds.map((i) => BigInt.from(i)).toList()));
    }
    if (starred != null) {
      query = query..where((t) => t.starred.equals(starred));
    }
    if (startTime != null) {
      query = query..where((t) => t.publishedAt.isBiggerOrEqualValue(startTime));
    }

    final orderByColumn = switch(orderx) {
      Frc.orderxCreatedAt => entriesTable.createdAt,
      _ => entriesTable.publishedAt,
    };

    final ordering = direction.toLowerCase() == 'asc'
        ? OrderingMode.asc
        : OrderingMode.desc;
    
    query..orderBy([(t) => OrderingTerm(expression: orderByColumn, mode: ordering)])
    ..limit(size, offset: (page - 1) * size);

    return await query.get();
  }

  Future<List<EntryEntity>> getAllEntries() async {
    return await select(entriesTable).get();
  }

  Future<List<EntryEntity>> getAllEntriesByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    return await (select(entriesTable)..where((t) => t.id.isIn(ids.map((e) => BigInt.from(e)).toList()))).get();
  }

  Future<EntryEntity?> getEntry(int entryId) async {
    return await (select(entriesTable)..where((t) => t.id.equals(BigInt.from(entryId)))).getSingleOrNull();
  }

  Future<bool> updateStatus(int entryId, {String? status, bool? starred}) async {
    final affectedRows = await (update(entriesTable)
      ..where((t) => t.id.equals(BigInt.from(entryId)))
    ).write(
      EntriesTableCompanion(
        status: status != null ? Value(status) : const Value.absent(),
        starred: starred != null ? Value(starred) : const Value.absent(),
      )
    );
    return affectedRows > 0;
  }

  Future<DateTime?> getMaxChangedAt() async {
    final query = selectOnly(entriesTable);
    final maxChangedAt = entriesTable.changedAt.max();
    query.addColumns([maxChangedAt]);
    final result = await query.getSingleOrNull();
    return result?.read(maxChangedAt);
  }

  Future<int> count() async {
    final query = selectOnly(entriesTable);
    final countExpr = countAll();
    query.addColumns([countExpr]);
    final result = await query.getSingle();
    return result.read(countAll()) ?? 0;
  }


  Future<SmartListCount> countSmartList() async {
    final now = DateTime.now().toUtc();
    final todayStart = DateTime(now.year, now.month, now.day);
    final tomorrowStart = todayStart.add(const Duration(days: 1));

    final query = '''
    SELECT 
      COUNT(*) AS total,
      ifnull(SUM(CASE WHEN status = 'read' THEN 1 ELSE 0 END), 0) AS read_count,
      ifnull(SUM(CASE WHEN status = 'unread' THEN 1 ELSE 0 END), 0) AS unread_count,
      ifnull(SUM(CASE WHEN starred THEN 1 ELSE 0 END), 0) AS starred_count,
      ifnull(SUM(CASE WHEN published_at >= ? THEN 1 ELSE 0 END), 0) AS today_count
    FROM entries;
  ''';
    final result = await db.customSelect(
      query,
      variables: [Variable(todayStart)],
    ).getSingle();

    return SmartListCount(
      total: result.read<int>('total'),
      read: result.read<int>('read_count'),
      unread: result.read<int>('unread_count'),
      starred: result.read<int>('starred_count'),
      today: result.read<int>('today_count'),
    );
  }

}