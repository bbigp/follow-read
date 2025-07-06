//
//
// import 'package:drift/drift.dart';
//
// import 'database.dart';
// import 'entities/search_entity.dart';
//
// @DriftAccessor(tables: [SearchTable])
// class SearchDao extends DatabaseAccessor<AppDatabase> {
//
//   SearchDao(super.db);
//
//   $SearchTableTable get searchTable => attachedDatabase.searchTable;
//
//
//   void save(String word,) async {
//     if (word == "") return;
//     await into(searchTable).insert(SearchTableCompanion(
//       word: Value(word.trim()),
//       createdAt: Value(DateTime.now()),
//     ));
//   }
//
//
//   Future<List<String>> getAll() async {
//     // final result = await customSelect(
//     //   'SELECT name FROM search ORDER BY id DESC LIMIT 15',
//     //   readsFrom: {searchTable},
//     // ).get();
//     //
//     // final names = result.map((row) => row.read<String>('name')).toList();
//     var query = selectOnly(searchTable, distinct: true)
//       ..addColumns([searchTable.word])
//       ..orderBy([OrderingTerm(expression: searchTable.id, mode: OrderingMode.desc)])
//       ..limit(15);
//     final rows = await query.get();
//     return rows.map((row) => row.read(searchTable.word)!).toList();
//   }
//
//
//   void deleteData() async {
//     await delete(searchTable).go();
//   }
//
//
//
// }
//
