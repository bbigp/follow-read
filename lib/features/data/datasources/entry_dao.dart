

import 'package:drift/drift.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/domain/cases/base.dart';

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

  Future<List<EntryEntity>> fetch(int page, int size, SQLQueryBuilder builder) async {
    var query = select(entriesTable)..where((t) => entriesTable.status.isIn(builder.statuses));
    if (builder.feedIds.isNotEmpty){
      query = query..where((t) => t.feedId.isIn(builder.feedIds.map((i) => BigInt.from(i)).toList()));
    }
    if (builder.starred) {
      query = query..where((t) => t.starred.equals(true));
    }
    if (builder.minPublishedTime != null) {
      query = query..where((t) => t.publishedAt.isBiggerOrEqualValue(builder.minPublishedTime!));
    }
    if (builder.minAddTime != null) {
      query = query..where((t) => t.createdAt.isBiggerOrEqualValue(builder.minAddTime!));
    }

    final orderByColumn = switch(builder.order) {
      Frc.orderxCreatedAt => entriesTable.createdAt,
      _ => entriesTable.publishedAt,
    };

    // final ordering = direction.toLowerCase() == 'asc'
    //     ? OrderingMode.asc
    //     : OrderingMode.desc;

    query..orderBy([(t) => OrderingTerm(expression: orderByColumn, mode: OrderingMode.desc)])
      ..limit(size, offset: (page - 1) * size);

    return await query.get();
  }

  Future<List<EntryEntity>> paginateEntries({
    List<int> feedIds = const[],
    int page = 1,
    int size = 20, List<String> status = const ['unread'],
    String? order, String direction = "desc",
    bool? starred, DateTime? minPublishedTime, String? word,
    DateTime? minAddTime,
  }) async {
    var query = select(entriesTable)..where((t) => entriesTable.status.isIn(status));
    if (feedIds.isNotEmpty){
      query = query..where((t) => t.feedId.isIn(feedIds.map((i) => BigInt.from(i)).toList()));
    }
    if (starred != null) {
      query = query..where((t) => t.starred.equals(starred));
    }
    if (minPublishedTime != null) {
      query = query..where((t) => t.publishedAt.isBiggerOrEqualValue(minPublishedTime));
    }
    if (minAddTime != null) {
      query = query..where((t) => t.createdAt.isBiggerOrEqualValue(minAddTime));
    }
    if (word != null && word != "") {
      final keyword = '%$word%';
      query = query..where((t) => t.title.like(keyword) | t.content.like(keyword) | t.summary.like(keyword));
    }

    final orderByColumn = switch(order) {
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

  Future<Map<int, int>> countFeed() async {
    final query = '''
       select feed_id, count(*) filter (where status = 'unread') as unread
       from entries
       group by feed_id
    ''';
    final result = await db.customSelect(
      query,
    ).get();
    final map = <int, int>{};
    for (final row in result) {
      final id = row.read<int>('feed_id');
      final count = row.read<int>('unread');
      map[id] = count;
    }
    return map;
  }

  Future<Map<int, int>> countCluster(List<ClusterEntity> clusters) async {
    final parts = clusters.map(buildQuery).join(", ");
    final query = "SELECT $parts FROM entries";
    logger.i(query);
    final result = await db.customSelect(
      query,
    ).getSingle();
    return Map<int, int>.fromEntries(
      result.data.entries.map((entry) {
        final key = int.parse(entry.key);
        final value = entry.value as int;
        return MapEntry(key, value);
      }),
    );
  }

  String buildQuery(ClusterEntity cluster) {
    List<String> cond = [];
    if (cluster.feedIds.isNotEmpty) {
      cond.add("feed_id in (${cluster.feedIds})");
    }
    if (cluster.recentTime > 0) {
      var time = DateTime.now().add(Duration(minutes: -cluster.recentTime)).millisecondsSinceEpoch ~/ 1000;
      cond.add("published_at >= $time");
    }
    if (cluster.recentAddTime > 0) {
      var time = DateTime.now().add(Duration(minutes: -cluster.recentAddTime)).millisecondsSinceEpoch ~/ 1000;
      cond.add("created_at >= $time");
    }
    if (cluster.statuses.isNotEmpty) {
      var status = cluster.statuses.split(',').map((status) => "'$status'").toSet().join(",");
      cond.add("status in ($status)");
    }
    bool? starred = switch(cluster.starred) {
      1 => true,
      0 => false,
      _ => null
    };
    if (starred != null) {
      cond.add("starred = $starred");
    }
    if (cond.isEmpty) {
      cond.add("true");
    }
    var query = "count(*) filter (where ${cond.join(" and ")}) as '${cluster.id}' ";
    return query;
  }

  //
  // Future<SmartListCount> countSmartList() async {
  //
  //   final now = DateTime.now().toUtc();
  //   final todayStart = DateTime(now.year, now.month, now.day);
  //   // final tomorrowStart = todayStart.add(const Duration(days: 1));
  //
  //   final query = '''
  //   SELECT
  //     COUNT(*) AS total,
  //     ifnull(SUM(CASE WHEN status = 'read' THEN 1 ELSE 0 END), 0) AS read_count,
  //     ifnull(SUM(CASE WHEN status = 'unread' THEN 1 ELSE 0 END), 0) AS unread_count,
  //     ifnull(SUM(CASE WHEN starred THEN 1 ELSE 0 END), 0) AS starred_count,
  //     ifnull(SUM(CASE WHEN published_at >= ? THEN 1 ELSE 0 END), 0) AS today_count
  //   FROM entries;
  // ''';
  //
  //
  //
  //   final result = await db.customSelect(
  //     query,
  //     variables: [Variable(todayStart)],
  //   ).getSingle();
  //
  //   return SmartListCount(
  //     total: result.read<int>('total'),
  //     read: result.read<int>('read_count'),
  //     unread: result.read<int>('unread_count'),
  //     starred: result.read<int>('starred_count'),
  //     today: result.read<int>('today_count'),
  //   );
  // }

  // return result.map((row) {
  // return UnreadCount(
  // id: row.read<int>('id') ?? 0,
  // count: row.read<int>('unread') ?? 0,
  // );
  // }).toList();

  Future<bool> deleteByFeedId(int feedId) async {
    var query = delete(entriesTable)..where((f) => f.feedId.equals(BigInt.from(feedId)));
    var affectedRows = await query.go();
    return affectedRows > 0;
  }

}