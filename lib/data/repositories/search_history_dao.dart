

import 'package:drift/drift.dart';

import 'app_database.dart';

class SearchHistoryDao extends DatabaseAccessor<AppDatabase> {

  SearchHistoryDao(super.attachedDatabase);

  $SearchHistoryTableTable get searchHistoryTable => attachedDatabase.searchHistoryTable;

  void save(String word, String metaId, BigInt userId) async {
    if (word == "") return;
    await into(searchHistoryTable).insert(SearchHistoryTableCompanion(
      word: Value(word.trim()),
      createdAt: Value(DateTime.now()),
      metaId: Value(metaId),
      userId: Value(userId),
    ));
  }


  Future<List<String>> getAll({String? metaId}) async {
    // final result = await customSelect(
    //   'SELECT name FROM search ORDER BY id DESC LIMIT 15',
    //   readsFrom: {searchTable},
    // ).get();
    //
    // final names = result.map((row) => row.read<String>('name')).toList();
    var query = selectOnly(searchHistoryTable, distinct: true)
      ..addColumns([searchHistoryTable.word])
      ..orderBy([OrderingTerm(expression: searchHistoryTable.id, mode: OrderingMode.desc)])
      ..limit(15);
    if (metaId != null) {
      query = query..where(searchHistoryTable.metaId.equals(metaId));
    }
    final rows = await query.get();
    return rows.map((row) => row.read(searchHistoryTable.word) ?? "").toList();
  }


  Future<void> deleteAll() async {
    await delete(searchHistoryTable).go();
  }



}

