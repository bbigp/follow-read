//
//
// import 'package:drift/drift.dart';
// import 'package:follow_read/core/utils/logger.dart';
// import 'package:follow_read/modules/pages/entries/meta_data.dart';
//
// import '../../domain/models/constants.dart';
// import 'database.dart';
// import 'entities/entry_entity.dart';
//
// part 'entry_dao.g.dart';
//


//
//   Future<bool> updateStatus(int entryId, {String? status, bool? starred}) async {
//     final affectedRows = await (update(entriesTable)
//       ..where((t) => t.id.equals(BigInt.from(entryId)))
//     ).write(
//       EntriesTableCompanion(
//         status: status != null ? Value(status) : const Value.absent(),
//         starred: starred != null ? Value(starred) : const Value.absent(),
//       )
//     );
//     return affectedRows > 0;
//   }
//
//   Future<DateTime?> getMaxChangedAt() async {
//     final query = selectOnly(entriesTable);
//     final maxChangedAt = entriesTable.changedAt.max();
//     query.addColumns([maxChangedAt]);
//     final result = await query.getSingleOrNull();
//     return result?.read(maxChangedAt);
//   }
//

//

//
// }