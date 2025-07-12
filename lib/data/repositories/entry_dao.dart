

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
    final parts = filters.map(buildQuery).join(", ");
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

  String buildQuery(Filter filter) {
    List<String> cond = [];
    var now = DateTime.now();
    if (filter.feedIds.isNotEmpty) {
      final ids = filter.feedIds.map((id) => id.toString()).join(", ");
      cond.add("feed_id in ($ids)");
    }
    if (filter.publishedTime > 0) {
      var time = now.add(Duration(minutes: -filter.publishedTime)).millisecondsSinceEpoch ~/ 1000;
      cond.add("published_at >= $time");
    }
    if (filter.addTime > 0) {
      var time = now.add(Duration(minutes: -filter.addTime)).millisecondsSinceEpoch ~/ 1000;
      cond.add("created_at >= $time");
    }
    if (filter.statuses.isNotEmpty) {
      var status = filter.statuses.map((status) => "'$status'").toSet().join(",");
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
    var query = "count(*) filter (where ${cond.join(" and ")}) as '${filter.id}' ";
    return query;
  }

}