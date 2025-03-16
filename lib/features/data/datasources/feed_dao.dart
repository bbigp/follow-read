
import 'package:drift/drift.dart';

import 'database.dart';
import 'feed_entity.dart';

part 'feed_dao.g.dart';

@DriftAccessor(tables: [FeedsTable])
class FeedDao extends DatabaseAccessor<AppDatabase> with _$FeedDaoMixin {
  FeedDao(super.db);


  Future<void> bulkInsertWithTransaction(List<FeedsTableCompanion> feeds) async {
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

  Future<List<FeedEntity>> getAllFeeds() async {
    return await select(feedsTable).get();
  }

}