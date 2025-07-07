


import 'package:drift/drift.dart';

@DataClassName("FolderRow")
class FoldersTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  TextColumn get title => text().named('title')();
  BoolColumn get hideGlobally => boolean().named("hide_globally")
      .withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "folders";
}