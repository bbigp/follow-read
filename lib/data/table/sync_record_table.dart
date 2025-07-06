

import 'package:drift/drift.dart';

@DataClassName("SyncRecordRow")
class SyncRecordsTable extends Table {

  Int64Column get id => int64().named("id").autoIncrement()();
  TextColumn get status => text().named('status')();
  DateTimeColumn get time => dateTime().named('time')
      .withDefault(Constant(DateTime.now()))();
  TextColumn get errorMsg => text().named('errorMsg')();
  DateTimeColumn get startTime => dateTime().named('startTime')
      .withDefault(Constant(DateTime.now()))();
  DateTimeColumn get endTime => dateTime().named('endTime')
      .withDefault(Constant(DateTime.now()))();
  IntColumn get entry => integer().named("entry")();
  IntColumn get feed => integer().named("feed")();
  IntColumn get category => integer().named("category")();

  @override
  String? get tableName => "sync_records";

}