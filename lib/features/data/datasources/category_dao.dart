

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

  Future<List<CategoryEntity>> getAll({bool? hideGlobally}) async {
    var query = select(categoriesTable);
    if (hideGlobally != null) {
      query = query..where((t) => t.hideGlobally.equals(hideGlobally));
    }
    return await query.get();
  }

  Future<CategoryEntity> getCategoryById(int id) async {
    return await (select(categoriesTable)..where((t) => t.id.equals(BigInt.from(id)))).getSingle();
  }

  Future<bool> updateShow(int id, {bool? onlyShowUnread, bool? showReadingTime,
  String? orderx, bool? hideGlobally, }) async {
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
        orderx: orderx != null && orderx != "" ? Value(orderx) : const Value.absent(),
        hideGlobally: hideGlobally != null ? Value(hideGlobally) : const Value.absent(),
      ),
    );
    return affectedRows > 0;
  }

}

