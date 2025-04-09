import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:follow_read/features/data/datasources/entities/category_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../../core/utils/logger.dart';
import 'entities/conf_entity.dart';
import 'entities/entry_entity.dart';
import 'entities/feed_entity.dart';

part 'database.g.dart';

@DriftDatabase(tables: [FeedsTable, EntriesTable, CategoriesTable, ConfTable])
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
    final file = File(p.join(dbFolder.path, 'follow.db'));
    return NativeDatabase.createInBackground(file,
        setup: (db) {
          db.execute("PRAGMA encoding = 'UTF-8'"); // ✅ 强制 UTF-8
        }
    );
  });
}
