
import 'package:drift/drift.dart';
import 'package:follow_read/features/data/models/feed_counter_response.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import 'database.dart';
import 'entities/feed_entity.dart';

part 'feed_dao.g.dart';

@DriftAccessor(tables: [FeedsTable])
class FeedDao extends DatabaseAccessor<AppDatabase> with _$FeedDaoMixin {
  FeedDao(super.db);


  Future<void> bulkInsertWithTransaction(List<FeedsTableCompanion> feeds) async {
    if (feeds.isEmpty) {
      return;
    }
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(
          feedsTable,
          feeds,
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<FeedEntity> getFeed(int feedId) async {
    return await (select(feedsTable)..where((t) => t.id.equals(BigInt.from(feedId)))).getSingle();
  }

  Future<List<FeedEntity>> getAllFeeds() async {
    return await select(feedsTable).get();
  }

  Future<List<FeedEntity>> getFeedsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    return await (select(feedsTable)..where((t) => t.id.isIn(ids.map((e) => BigInt.from(e)).toList()))).get();
  }

  Future<FeedEntity> getFeedById(int id) async {
    return await (select(feedsTable)..where((t) => t.id.equals(BigInt.from(id)))).getSingle();
  }

  Future<void> bulkUpdateCounter(List<FeedCounter> list) async {
    if (list.isEmpty) {
      return;
    }
    await transaction(() async {
      for (var item in list) {
        await (update(feedsTable)..where((r) => r.id.equals(item.id)))
            .write(FeedsTableCompanion(read: Value(item.read), unread: Value(item.unread)));
      }
    });
  }

}