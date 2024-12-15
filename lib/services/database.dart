import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../models/feed.dart';
import '../utils/logger.dart';

part 'database.g.dart';

class FeedsData extends Table {
  IntColumn get id => integer()();
  IntColumn get userId => integer()();
  TextColumn get feedUrl => text()();
  TextColumn get siteUrl => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get checkedAt => text()();
  TextColumn get nextCheckAt => text()();
  IntColumn get icon => integer().nullable()();
  TextColumn get parsingErrorMsg => text().nullable()();
  IntColumn get parsingErrorCount => integer().withDefault(const Constant(0))();
  IntColumn get read => integer().withDefault(const Constant(0))();
  IntColumn get unread => integer().withDefault(const Constant(0))();
}


@DriftDatabase(tables: [FeedsData])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connect());

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

  Future<void> insertFeed(Feed feed) async {
    await into(feedsData).insert(feed.toFeedsData());
  }

  Future<List<Feed>> getAllFeeds() async {
    try {
      final results = await (select(feedsData)).get();
      return results.map((entry) => Feed.fromEntry(entry)).toList();
    } catch (e) {
      logger.e("select feeds失败$e");
      return [];
    }
  }

  Future<void> deleteAllFeeds() => delete(feedsData).go();

  Future<void> insertFeeds(List<Feed> feeds) async {
    await batch((batch) {
      batch.insertAll(
        feedsData,
        feeds.map((feed) => feed.toFeedsData()),
        mode: InsertMode.replace,
      );
    });
  }

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

DatabaseConnection connect() {
  final db = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'feeds.db'));
    return NativeDatabase.createInBackground(file);
  });
  return DatabaseConnection(db);
}