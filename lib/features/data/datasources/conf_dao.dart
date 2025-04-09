


import 'package:drift/drift.dart';

import 'database.dart';
import 'entities/conf_entity.dart';

mixin _$ConfMixin on DatabaseAccessor<AppDatabase> {
  $ConfTableTable get confTable => attachedDatabase.confTable;
  $CategoriesTableTable get categoriesTable => attachedDatabase.categoriesTable;
}

@DriftAccessor(tables: [ConfTable])
class ConfDao extends DatabaseAccessor<AppDatabase> with _$ConfMixin {

  ConfDao(super.db);

  Future<List<ConfEntity>> getByUserId(int userId) async {
    return await (select(confTable)..where((t) => t.userId.equals(BigInt.from(userId)))).get();
  }


  Future<void> saveConf(int userId, {bool? autoRead, bool? showHide}) async {
    List<ConfTableCompanion> list = [];
    if (autoRead != null) {
      list.add(ConfTableCompanion(
        name: Value("autoRead"),
        value: Value(autoRead.toString()),
        userId: Value(BigInt.from(userId)),
      ));
    }
    if (showHide != null) {
      list.add(ConfTableCompanion(
        name: Value("showHide"),
        value: Value(showHide.toString()),
        userId: Value(BigInt.from(userId)),
      ));
    }
    if (list.isEmpty) return;
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(
          confTable,
          list,
          mode: InsertMode.insertOrReplace,
        );
      });
    });


  }

}

