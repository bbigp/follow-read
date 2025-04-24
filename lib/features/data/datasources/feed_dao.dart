
import 'package:drift/drift.dart';
import 'package:follow_read/features/data/models/feed_counter_response.dart';

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
      var query = update(feedsTable);
      await query.write(FeedsTableCompanion(deleted: Value(1)));
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
    return await (select(feedsTable)
      ..where((t) => t.id.equals(BigInt.from(feedId)))
      ..where((t) => t.deleted.equals(0))
    ).getSingle();
  }

  Future<List<FeedEntity>> getAllFeeds({bool? hideGlobally, List<int>? ids}) async {
    var query = select(feedsTable);
    if (hideGlobally != null) {
      query = query..where((t) => t.hideGlobally.equals(hideGlobally));
    }
    if (ids != null && ids.isNotEmpty) {
      query = query..where((t) => t.id.isIn(ids.map((item) => BigInt.from(item)).toList()));
    }
    query = query..where((t) => t.deleted.equals(0));
    return await query.get();
  }

  Future<List<FeedEntity>> getFeedsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    return await (select(feedsTable)
      ..where((t) => t.id.isIn(ids.map((e) => BigInt.from(e)).toList()))
      ..where((t) => t.deleted.equals(0))
    ).get();
  }

  Future<List<FeedEntity>> getFeedsByCategoryId(int categoryId) async {
    return await (select(feedsTable)
      ..where((t) => t.categoryId.equals(BigInt.from(categoryId)))
      ..where((t) => t.deleted.equals(0))
    ).get();
  }

  Future<FeedEntity> getFeedById(int id) async {
    return await (select(feedsTable)
      ..where((t) => t.id.equals(BigInt.from(id)))
      ..where((t) => t.deleted.equals(0))
    ).getSingle();
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

  Future<bool> deleteById(int feedId) async {
    var query = delete(feedsTable)..where((r) => r.id.equals(BigInt.from(feedId)));
    var affectedRows = await query.go();
    return affectedRows > 0;
  }

  Future<bool> updateShow(int feedId, {bool? onlyShowUnread, bool? showReadingTime,
    String? orderx, bool? hideGlobally,
    String? title, int? categoryId,
  }) async {
    final affectedRows = await (update(feedsTable)
      ..where((t) => t.id.equals(BigInt.from(feedId)))
    ).write(
      FeedsTableCompanion(
        title: title != null && title != "" ? Value(title) : const Value.absent(),
        categoryId: categoryId != null ? Value(BigInt.from(categoryId)) : const Value.absent(),
        onlyShowUnread: onlyShowUnread != null ? Value(onlyShowUnread) : const Value.absent(),
        showReadingTime: showReadingTime != null ? Value(showReadingTime) : const Value.absent(),
        orderx: orderx != null && orderx != "" ? Value(orderx) : const Value.absent(),
        hideGlobally: hideGlobally != null ? Value(hideGlobally) : const Value.absent(),
      ),
    );
    return affectedRows > 0;
  }

}