


import 'package:drift/drift.dart';
import 'package:follow_read/data/model/filter.dart';

import 'app_database.dart';

class FilterDao extends DatabaseAccessor<AppDatabase> {

  FilterDao(super.attachedDatabase);

  $FiltersTableTable get filtersTable => attachedDatabase.filtersTable;


  Future<void> save(Filter f) async {
    await into(filtersTable).insertOnConflictUpdate(FiltersTableCompanion(
      id: f.id == BigInt.zero ? Value.absent() : Value(f.id),
      userId: Value(f.userId),
      name: Value(f.name), icon: Value(f.icon),
      feedIds: Value(f.feedIds.join(",")),
      publishedTime: Value(f.publishedTime), statuses: Value(f.statuses.join(",")),
      addTime: Value(f.addTime),
      deleted: Value(f.deleted),
      createdAt: Value(f.createdAt), changedAt: Value(f.changedAt),
      orderx: Value(f.order),
      hideGlobally: Value(f.hideGlobally),
      onlyShowUnread: Value(f.hideGlobally),
    ));
  }


  Future<List<Filter>> getAllFilters() async {
    var query = select(filtersTable);
    query = query..where((t) => t.deleted.equals(0))
      ..orderBy([(t) => OrderingTerm(expression: filtersTable.id, mode: OrderingMode.asc)]);
    final rows = await query.get();
    return rows.map((e) => e.toFilter()).toList();
  }


}