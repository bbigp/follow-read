
import 'package:drift/drift.dart';
import 'package:follow_read/features/data/datasources/database.dart';
import 'package:follow_read/features/domain/models/category.dart';

@DataClassName("CategoryEntity")
class CategoriesTable extends Table {

  Int64Column get id => int64().named("id")();
  TextColumn get title => text().named('title')();
  Int64Column get userId => int64().named('user_id')();
  BoolColumn get hideGlobally => boolean().named('hide_globally')
      .withDefault(const Constant(false))();

  BoolColumn get onlyShowUnread => boolean().named('only_show_unread')
      .withDefault(const Constant(false))();
  BoolColumn get showReadingTime => boolean().named('show_reading_time')
      .withDefault(const Constant(false))();

  TextColumn get orderx => text().named("orderx")
      .withDefault(Constant("published_at"))();


  List<Index> get indexes => [
    Index('unique_userid_title', 'UNIQUE(user_id, title)')
  ];

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "categories";
}


extension CategoryEntityConversion on CategoryEntity {
  Category toModel() {
    return Category(
      id: id.toInt(),
      title: title,
      userId: userId.toInt(),
      hideGlobally: hideGlobally,
      onlyShowUnread: onlyShowUnread,
      showReadingTime: showReadingTime,
      orderx: orderx,
    );
  }
}