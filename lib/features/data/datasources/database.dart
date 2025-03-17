import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../../core/utils/logger.dart';
import 'entities/feed_entity.dart';

part 'database.g.dart';

@DriftDatabase(tables: [FeedsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;  // 增加版本号

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // if (from < 3) {
      //   await m.addColumn(feedsData, feedsData.read);
      //   await m.addColumn(feedsData, feedsData.unread);
      // }
    },
  );

  // Future<void> insertFeed(Feed feed) async {
  //   await into(feedsData).insert(feed.toFeedsData());
  // }
  //
  // Future<List<Feed>> getAllFeeds() async {
  //   try {
  //     final results = await (select(feedsData)).get();
  //     return results.map((entry) => Feed.fromEntry(entry)).toList();
  //   } catch (e) {
  //     logger.e("select feeds失败$e");
  //     return [];
  //   }
  // }
  //
  // Future<void> deleteAllFeeds() => delete(feedsData).go();
  //
  // Future<void> insertFeeds(List<Feed> feeds) async {
  //   await batch((batch) {
  //     batch.insertAll(
  //       feedsData,
  //       feeds.map((feed) => feed.toFeedsData()),
  //       mode: InsertMode.replace,
  //     );
  //   });
  // }

  // 监听 Feed 变化
  // Stream<List<Feed>> watchAllFeeds() {
  //   return select(feeds).watch().map((rows) => rows.map((row) => Feed(
  //     id: row.id,
  //     title: row.title,
  //     link: row.link,
  //     description: row.description,
  //     iconId: row.iconId,
  //     createdAt: row.createdAt,
  //     updatedAt: row.updatedAt,
  //   )).toList());
  // }
}
LazyDatabase _openConnection() {
  logger.i("数据库初始化完成");
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'follow.db'));
    return NativeDatabase(file);
  });
}

// DatabaseConnection connect() {
//   final db = LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'follow.db'));
//     return NativeDatabase.createInBackground(file);
//   });
//   return DatabaseConnection(db);
// }