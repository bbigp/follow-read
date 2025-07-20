


import 'package:drift/drift.dart';

@DataClassName("MediaRow")
class MediasTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  Int64Column get entryId => int64().named("entry_id")();
  TextColumn get url => text().named('url')();
  TextColumn get mimeType => text().named('mime_type')();
  IntColumn get size => integer().named("size")();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "medias";
}