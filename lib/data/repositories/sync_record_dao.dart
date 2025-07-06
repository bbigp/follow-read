

import 'package:drift/drift.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/sync_record.dart';

import 'app_database.dart';

class SyncRecordDao extends DatabaseAccessor<AppDatabase> {

  SyncRecordDao(super.attachedDatabase);

  $SyncRecordsTableTable get syncRecordsTable => attachedDatabase.syncRecordsTable;

  Future<BigInt> save(SyncRecord record) async {
    final row = await into(syncRecordsTable).insertReturning(SyncRecordsTableCompanion(
      status: Value(record.status),
      time: Value(record.time),
      errorMsg: Value(record.errorMsg),
      startTime: record.startTime == null ? const Value.absent() : Value(record.startTime!),
      endTime: record.endTime == null ? const Value.absent() : Value(record.endTime!),
      entry: Value(record.entry),
      feed: Value(record.feed), category: Value(record.category),
    ));
    return row.id;
  }

  Future<bool> updateFinish(BigInt id, String status, {
    int? entry, int? feed, int? category, String errorMsg = ""
  }) async {
    var query = update(syncRecordsTable)..where((t) => t.id.equals(id));
    final affectedRows = await query.write(SyncRecordsTableCompanion(
      status: Value(status),
      entry: entry == null ? const Value.absent() : Value(entry),
      feed: feed == null ? const Value.absent() : Value(feed),
      category: category == null ? const Value.absent() : Value(category),
      errorMsg: Value(errorMsg),
    ));
    return affectedRows > 0;
  }

}