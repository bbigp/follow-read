
import 'package:drift/drift.dart';

import 'database.dart';
import 'entities/entry_entity.dart';

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

  Future<List<EntryEntity>> getEntriesByFeedId(int feedId) async {
    return await (select(entriesTable)..where((r) => r.feedId.equals(BigInt.from(feedId)))).get();
  }

  Future<List<EntryEntity>> getAllEntries() async {
    return await select(entriesTable).get();
  }

  Future<List<EntryEntity>> getAllEntriesByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    return await (select(entriesTable)..where((t) => t.id.isIn(ids.map((e) => BigInt.from(e)).toList()))).get();
  }

  Future<EntryEntity?> getEntry(int entryId) async {
    return await (select(entriesTable)..where((t) => t.id.equals(BigInt.from(entryId)))).getSingleOrNull();
  }

  Future<bool> updateStatus(int entryId, {String? status, bool? starred}) async {
    final affectedRows = await (update(entriesTable)
      ..where((t) => t.id.equals(BigInt.from(entryId)))
    ).write(
      EntriesTableCompanion(
        status: status != null ? Value(status) : const Value.absent(),
        starred: starred != null ? Value(starred) : const Value.absent(),
      )
    );
    return affectedRows > 0;
  }

}