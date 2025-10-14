

import 'package:drift/drift.dart';
import 'package:follow_read/data/model/pending_change.dart';

import 'app_database.dart';

class PendingChangeDao extends DatabaseAccessor<AppDatabase> {

  PendingChangeDao(super.attachedDatabase);

  $PendingChangeTableTable get pendingChangeTable => attachedDatabase.pendingChangeTable;


  Future<void> save(String contentId, {required userId, required PendingChangeAction action,
    PendingChangeStatus status = PendingChangeStatus.pending,
    String extra  = "",
  }) async {
    if (contentId == "" || userId == null) return;
    await into(pendingChangeTable).insert(PendingChangeTableCompanion(
      userId: Value(userId),
      contentId: Value(contentId),
      action: Value(action),
      status: Value(status),
      extra: Value(extra),
      createdAt: Value(DateTime.now()),
    ));
  }

  Future<List<PendingChange>> getPage(BigInt userId, {int page = 1, int size = 20}) async {
    var query = select(pendingChangeTable)
      ..limit(size, offset: (page -1) * size)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
    ;
    final rows = await query.get();
    return rows.map((e) => e.to()).toList();
  }

  Future<void> deleteById(int id) async {
    var query = delete(pendingChangeTable)..where((t) => t.id.equals(id));
    await query.go();
  }

}