
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/table/feed_table.dart';
import 'package:follow_read/data/table/sync_record_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [FeedsTable, SyncRecordsTable])
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

    },
  );


}

LazyDatabase _openConnection() {
  logger.i("数据库初始化完成");
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mini-follow.db'));
    return NativeDatabase.createInBackground(file,
        setup: (db) {
          db.execute("PRAGMA encoding = 'UTF-8'"); // ✅ 强制 UTF-8
        }
    );
  });
}
