

import 'package:drift/drift.dart';

import 'database.dart';
import 'entities/category_entity.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [CategoriesTable])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {

  CategoryDao(super.db);


  Future<void> bulkInsertWithTransaction(List<CategoriesTableCompanion> list) async {
    if (list.isEmpty) {
      return;
    }
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(
          categoriesTable,
          list,
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<CategoryEntity>> getAll() async {
    return await select(categoriesTable).get();
  }

  Future<CategoryEntity> getCategoryById(int id) async {
    return await (select(categoriesTable)..where((t) => t.id.equals(BigInt.from(id)))).getSingle();
  }

  Future<bool> updateShow(int id, {bool? onlyShowUnread, bool? showReadingTime}) async {
    final affectedRows = await (update(categoriesTable)
      ..where((t) => t.id.equals(BigInt.from(id)))
    ).write(
      CategoriesTableCompanion(
        onlyShowUnread: onlyShowUnread != null
            ? Value(onlyShowUnread)
            : const Value.absent(),
        showReadingTime: showReadingTime != null
            ? Value(showReadingTime)
            : const Value.absent(),
      ),
    );
    return affectedRows > 0;
  }

}

