

import 'package:drift/drift.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/filter.dart';

import 'app_database.dart';

class EntryDao extends DatabaseAccessor<AppDatabase> {

  EntryDao(super.attachedDatabase);

  $EntriesTableTable get entriesTable => attachedDatabase.entriesTable;

  Future<void> bulkInsertWithTransaction(List<Entry> entries) async {
    if (entries.isEmpty) {
      return;
    }
    var entry = entries.map((e) => EntriesTableCompanion(
      id: Value(e.id), userId: Value(e.userId), feedId: Value(e.feedId),
      status: Value(e.status.name),
      hash: Value(e.hash),
      title: Value(e.title), url: Value(e.url),
      content: Value(e.content), author: Value(e.author), summary: Value(e.summary),
      readingTime: Value(e.readingTime),
      publishedAt: Value(e.publishedAt),  createdAt: Value(e.createdAt), changedAt: Value(e.changedAt),
      starred: Value(e.starred),
    )).toList();
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(entriesTable, entry, mode: InsertMode.insertOrReplace,);
      });
    });
  }

  Future<Entry> getEntry(BigInt id) async {
    var query = select(entriesTable);
    query = query..where((t) => t.id.equals(id));
    final rows = await query.getSingle();
    return rows.toEntry();
  }

  Future<bool> updateStatus(List<BigInt> entryIds, EntryStatus state) async {
    if (entryIds.isEmpty) return true;
    var query = update(entriesTable)
      ..where((r) => r.id.isIn(entryIds));

    final affectedRows = await query.write(EntriesTableCompanion(
      status: Value(state.name),
    ));
    return affectedRows > 0;
  }

  Future<List<Entry>> entries({
    List<BigInt>? feedIds, List<String>? statuses,
    int? publishedTime, int? addTime,
    int? page, int? size,
    String? order, String direction = "desc",
  }) async {
    page = page ?? 1;
    size = size ?? 20;
    final whereClause = buildQuery(feedIds: feedIds, statuses: statuses, publishedTime: publishedTime,
      addTime: addTime,
    ).join(" and ");
    final orderByColumn = switch(order) {
      "createdAt" => "created_at",
      _ => "published_at",
    };
    final ordering = direction.toLowerCase() == 'asc'
        ? OrderingMode.asc.name
        : OrderingMode.desc.name;


    final query = '''
      select * from entries where $whereClause
      order by $orderByColumn $ordering
      limit $size offset ${(page-1)*size}
    ''';
    final result = await db.customSelect(query, readsFrom: {entriesTable}).get();
    return result.map((r) => entriesTable.map(r.data).toEntry()).toList();
    // final keyword = '%$word%';
   // query = query..where((t) => t.title.like(keyword) | t.content.like(keyword) | t.summary.like(keyword));

  }

  Future<Map<BigInt, int>> countFeed() async {
    final query = '''
       select feed_id, count(*) filter (where status = 'unread') as unread
       from entries
       group by feed_id
    ''';
    final result = await db.customSelect(
      query,
    ).get();
    final map = <BigInt, int>{};
    for (final row in result) {
      final id = row.read<BigInt>('feed_id');
      final count = row.read<int>('unread');
      map[id] = count;
    }
    return map;
  }

  Future<Map<BigInt, int>> countFilter(List<Filter> filters) async {
    if (filters.isEmpty) return {};
    // final parts = filters.map(buildQuery).join(", ");
    final parts = filters
        .map((e) =>
              "count(*) filter (where ${buildQuery(
                feedIds: e.feedIds,
                statuses: e.statuses,
                publishedTime: e.publishedTime,
                addTime: e.addTime,
              ).join(" and ")}) as '${e.id}' "
            )
        .join(", ");
    final query = "SELECT $parts FROM entries";
    logger.i(query);
    final result = await db.customSelect(
      query,
    ).getSingle();
    return Map<BigInt, int>.fromEntries(
      result.data.entries.map((entry) {
        return MapEntry(BigInt.parse(entry.key), entry.value as int);
      }),
    );
  }

  List<String> buildQuery({
    List<BigInt>? feedIds, int? publishedTime, int? addTime,
    List<String>? statuses,
  }) {
    List<String> cond = [];
    var now = DateTime.now();
    if (feedIds != null && feedIds.isNotEmpty) {
      final ids = feedIds.map((id) => id.toString()).join(", ");
      cond.add("feed_id in ($ids)");
    }
    if (publishedTime != null && publishedTime > 0) {
      var time = now.add(Duration(minutes: -publishedTime)).millisecondsSinceEpoch ~/ 1000;
      cond.add("published_at >= $time");
    }
    if (addTime != null && addTime > 0) {
      var time = now.add(Duration(minutes: -addTime)).millisecondsSinceEpoch ~/ 1000;
      cond.add("created_at >= $time");
    }
    if (statuses != null && statuses.isNotEmpty) {
      var status = statuses.map((status) => "'$status'").toSet().join(",");
      cond.add("status in ($status)");
    }
    // bool? starred = switch(filter.starred) {
    //   1 => true,
    //   0 => false,
    //   _ => null
    // };
    if (cond.isEmpty) {
      cond.add("true");
    }
    return cond;
  }
}