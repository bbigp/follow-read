
import 'package:drift/drift.dart';

@DataClassName("CategoryEntity")
class CategoriesTable extends Table {

  Int64Column get id => int64().named("id")();
  TextColumn get title => text().named('title')();
  Int64Column get userId => int64().named('user_id')();
  BoolColumn get hideGlobally => boolean().named('hide_globally')
      .withDefault(const Constant(false))();


  List<Index> get indexes => [
    Index('unique_userid_title', 'UNIQUE(user_id, title)')
  ];

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "categories";
}