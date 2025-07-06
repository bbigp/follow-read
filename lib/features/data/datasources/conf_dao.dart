//
//
//
// import 'package:drift/drift.dart';
//
// import '../../domain/models/conf.dart';
// import 'database.dart';
// import 'entities/conf_entity.dart';
//
// @DriftAccessor(tables: [ConfTable])
// class ConfDao extends DatabaseAccessor<AppDatabase> {
//
//   $ConfTableTable get confTable => attachedDatabase.confTable;
//
//   ConfDao(super.db);
//
//   Future<List<ConfEntity>> getByUserId(int userId) async {
//     return await (select(confTable)..where((t) => t.userId.equals(BigInt.from(userId)))).get();
//   }
//
//
//   Future<void> saveConf(int userId, {bool? autoRead, bool? showAll, List<String>? baseUrls}) async {
//     List<ConfTableCompanion> list = [];
//     if (autoRead != null) {
//       list.add(ConfTableCompanion(
//         name: Value(Conf.keyAutoRead),
//         value: Value(autoRead.toString()),
//         userId: Value(BigInt.from(userId)),
//       ));
//     }
//     if (showAll != null) {
//       list.add(ConfTableCompanion(
//         name: Value(Conf.keyShowAll),
//         value: Value(showAll.toString()),
//         userId: Value(BigInt.from(userId)),
//       ));
//     }
//     if (baseUrls != null && baseUrls.isNotEmpty) {
//       list.add(ConfTableCompanion(
//         name: Value(Conf.keyBaseUrls),
//         value: Value(baseUrls.join(",")),
//         userId: Value(BigInt.from(userId)),
//       ));
//     }
//     if (list.isEmpty) return;
//     await transaction(() async {
//       await batch((batch) {
//         batch.insertAll(
//           confTable,
//           list,
//           mode: InsertMode.insertOrReplace,
//         );
//       });
//     });
//
//
//   }
//
// }
//
