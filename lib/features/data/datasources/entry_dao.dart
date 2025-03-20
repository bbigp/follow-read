
import 'package:drift/drift.dart';
import 'package:follow_read/features/data/models/feed_counter_response.dart';

import 'database.dart';
import 'entities/entry_entity.dart';
import 'entities/feed_entity.dart';

part 'entry_dao.g.dart';

@DriftAccessor(tables: [EntriesTable])
class EntryDao extends DatabaseAccessor<AppDatabase> with _$EntryDaoMixin {
  EntryDao(super.db);


  Future<void> bulkInsertWithTransaction(List<EntriesTableCompanion> entries) async {
    if (entries.isEmpty) {
      return;
    }
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(
          entriesTable,
          entries,
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<EntryEntity>> getAllEntries() async {
    return await select(entriesTable).get();
  }

  Future<EntryEntity?> getEntry(int entryId) async {
    return await (select(entriesTable)..where((t) => t.id.equals(BigInt.from(entryId)))).getSingleOrNull();
  }

}