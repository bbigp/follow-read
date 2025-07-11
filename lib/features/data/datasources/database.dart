// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:follow_read/features/data/datasources/entities/category_entity.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
//
// import '../../../config/filter_icons.dart';
// import '../../../core/utils/logger.dart';
// import 'entities/cluster_entity.dart';
// import 'entities/conf_entity.dart';
// import 'entities/entry_entity.dart';
// import 'entities/feed_entity.dart';
// import 'entities/search_entity.dart';
//
// part 'database.g.dart';
//
// @DriftDatabase(tables: [FeedsTable, EntriesTable, CategoriesTable, ConfTable,
//   SearchTable, ClustersTable])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(_openConnection());
//
//   @override
//   int get schemaVersion => 1;  // 增加版本号
//
//   @override
//   MigrationStrategy get migration => MigrationStrategy(
//     onCreate: (Migrator m) async {
//       await m.createAll();
//       await _initDefaultData(m);
//     },
//     onUpgrade: (Migrator m, int from, int to) async {
//
//     },
//   );
//
//
//   Future<void> _initDefaultData(Migrator m) async {
//     await batch((batch) async {
//       batch.insertAll(clustersTable, [
//         ClustersTableCompanion(
//           name: Value("全部"), icon: Value(ClusterIcons.name(ClusterIcons.cards)),
//           feedIds: Value(""), recentTime: Value(0), starred: Value(-1),
//           statuses: Value(["unread", "read",].join(",")),
//           deleted: Value(0), createdAt: Value(DateTime.now()), changedAt: Value(DateTime.now()),
//         ),
//         ClustersTableCompanion(
//           name: Value("近期已读"), icon: Value(ClusterIcons.name(ClusterIcons.read)),
//           feedIds: Value(""), recentTime: Value(0), starred: Value(-1),
//           statuses: Value(["read",].join(",")),
//           deleted: Value(0), createdAt: Value(DateTime.now()), changedAt: Value(DateTime.now()),
//         ),
//         ClustersTableCompanion(
//           name: Value("未读"), icon: Value(ClusterIcons.name(ClusterIcons.unread)),
//           feedIds: Value(""), recentTime: Value(0), starred: Value(-1),
//           statuses: Value(["unread",].join(",")),
//           deleted: Value(0), createdAt: Value(DateTime.now()), changedAt: Value(DateTime.now()),
//         ),
//         ClustersTableCompanion(
//           name: Value("今日"), icon: Value(ClusterIcons.name(ClusterIcons.today)),
//           feedIds: Value(""), recentTime: Value(24 * 60), starred: Value(-1),
//           statuses: Value(["unread", "read",].join(",")),
//           deleted: Value(0), createdAt: Value(DateTime.now()), changedAt: Value(DateTime.now()),
//         ),
//         ClustersTableCompanion(
//           name: Value("星标"), icon: Value(ClusterIcons.name(ClusterIcons.collection)),
//           feedIds: Value(""), recentTime: Value(0), starred: Value(1),
//           statuses: Value(["unread", "read",].join(",")),
//           deleted: Value(0), createdAt: Value(DateTime.now()), changedAt: Value(DateTime.now()),
//         ),
//       ]);
//     });
//   }
// }
// LazyDatabase _openConnection() {
//   logger.i("数据库初始化完成");
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'follow.db'));
//     return NativeDatabase.createInBackground(file,
//         setup: (db) {
//           db.execute("PRAGMA encoding = 'UTF-8'"); // ✅ 强制 UTF-8
//         }
//     );
//   });
// }
