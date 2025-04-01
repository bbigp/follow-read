

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

}

