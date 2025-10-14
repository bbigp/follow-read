

import 'package:drift/drift.dart';
import 'package:follow_read/data/model/pending_change.dart';

@DataClassName("PendingChangeRow")
class PendingChangeTable extends Table {

  IntColumn get id => integer().autoIncrement()();
  Int64Column get userId => int64().named("user_id")();
  TextColumn get contentId => text().named("content_id")();
  IntColumn get action => integer().map(const PendingChangeActionConverter())();
  IntColumn get status => integer().map(const PendingChangeStatusConverter()).withDefault(const Constant(0))();
  TextColumn get extra => text().withDefault(const Constant(""))();
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(Constant(DateTime.now()))();
  DateTimeColumn get executeTime => dateTime().named("execute_time").nullable()();
  TextColumn get msg => text().withDefault(const Constant(""))();

  @override
  String? get tableName => "pending_changes";
}

class PendingChangeActionConverter extends TypeConverter<PendingChangeAction, int> {
  const PendingChangeActionConverter();
  @override
  PendingChangeAction fromSql(int fromDb) => PendingChangeAction.values[fromDb];
  @override
  int toSql(PendingChangeAction value) => value.index;
}

class PendingChangeStatusConverter extends TypeConverter<PendingChangeStatus, int> {
  const PendingChangeStatusConverter();
  @override
  PendingChangeStatus fromSql(int fromDb) => PendingChangeStatus.values[fromDb];
  @override
  int toSql(PendingChangeStatus value) => value.index;
}
