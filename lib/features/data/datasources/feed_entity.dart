
import 'package:drift/drift.dart';

@DataClassName("FeedEntity")
class FeedsTable extends Table {

  Int64Column get id => int64().named("id")();
  Int64Column get userId => int64().named('user_id')();
  TextColumn get feedUrl => text().named('feed_url')();
  TextColumn get siteUrl => text().named('site_url')();
  TextColumn get title => text().named('title')();

  @override
  Set<Column> get primaryKey => {id};

}