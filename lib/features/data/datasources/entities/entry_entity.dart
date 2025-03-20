
import 'package:drift/drift.dart';

@DataClassName("EntryEntity")
class EntriesTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  TextColumn get feedUrl => text().named('feed_url')();
  TextColumn get siteUrl => text().named('site_url')();
  TextColumn get title => text().named('title')();
  IntColumn get unread => integer().named('unread')
      .withDefault(const Constant(0))();
  IntColumn get read => integer().named('read')
      .withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};

}

// extension EntryEntityConversion on EntryEntity {
//   Entry toModel() {
//     return Entry(
//       id: id.toInt(),
//       title: title,
//       userId: userId.toInt(),
//       feedUrl: feedUrl,
//       siteUrl: siteUrl,
//       avatarUrl: "",
//       read: read,
//       unread: unread,
//       viewType: ViewType.feedItem,
//     );
//   }
// }