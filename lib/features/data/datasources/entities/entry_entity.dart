
import 'package:drift/drift.dart';

import '../../../domain/models/entry.dart';
import '../database.dart';

@DataClassName("EntryEntity")
class EntriesTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  Int64Column get feedId => int64().named('feed_id')();
  TextColumn get status => text().named('status')
      .withDefault(const Constant("unread"))();
  TextColumn get hash => text().named('hash')();
  TextColumn get title => text().named('title')();
  TextColumn get url => text().named('url')();
  DateTimeColumn get publishedAt => dateTime().named('published_at')
      .withDefault(Constant(DateTime.now()))();
  DateTimeColumn get createdAt => dateTime().named('created_at')
      .withDefault(Constant(DateTime.now()))();
  DateTimeColumn get changedAt => dateTime().named('changed_at')
      .withDefault(Constant(DateTime.now()))();
  TextColumn get summary => text().named('summary')
      .withDefault(const Constant(""))();
  TextColumn get content => text().named('content')
      .withDefault(const Constant(""))();
  TextColumn get author => text().named('author')
      .withDefault(const Constant(""))();
  BoolColumn get starred => boolean().named('starred')
      .withDefault(const Constant(false))();
  IntColumn get readingTime => integer().named('reading_time')
      .withDefault(const Constant(0))();


  List<Index> get indexes => [
    Index('unique_userid_hash', 'UNIQUE(user_id, hash)')
  ];

  @override
  Set<Column> get primaryKey => {id};

  @override
  String? get tableName => "entries";

}

// extension EntryEntityConversion on EntryEntity {
//   Entry toModel() {
//     return Entry(
//       id: id.toInt(),
//       title: title,
//       hash: hash,
//       userId: userId.toInt(),
//       feedId: feedId.toInt(),
//       status: status,
//       url: url,
//       publishedAt: publishedAt,
//       content: content,
//       author: author,
//       starred: starred,
//       readingTime: readingTime,
//       summary: summary,
//       createdAt: createdAt,
//     );
//   }
// }
//

