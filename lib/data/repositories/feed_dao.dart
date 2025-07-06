

import 'package:drift/drift.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/repositories/app_database.dart';

class FeedDao extends DatabaseAccessor<AppDatabase> {

  FeedDao(super.attachedDatabase);

  $FeedsTableTable get feedsTable => attachedDatabase.feedsTable;

  Future<void> batchSave(List<Feed> feeds) async {
    if (feeds.isEmpty) return;

    final buffer = StringBuffer();
    buffer.write('INSERT INTO feeds (id, user_id, feed_url, site_url, title, '
        'icon_url, error_count, error_msg, category_id, hide_globally, '
        'only_show_unread, orderx, deleted) VALUES '
    );

    final args = <Object?>[];
    for (int i = 0; i < feeds.length; i++) {
      buffer.write('(?, ?, ?, ?, ?,     ?, ?, ?, ?, ?,      ?, ?, ?)');
      if (i < feeds.length - 1) buffer.write(', ');
      args.addAll([
        feeds[i].id, feeds[i].userId, feeds[i].feedUrl, feeds[i].siteUrl, feeds[i].title,
        feeds[i].iconUrl, feeds[i].errorCount, feeds[i].errorMsg, feeds[i].categoryId, feeds[i].hideGlobally,
        feeds[i].onlyShowUnread, feeds[i].order, 0,
      ]);
    }
    buffer.write(' ON CONFLICT(id) DO UPDATE SET '
        'feed_url = excluded.feed_url, site_url = excluded.site_url,'
        'title = excluded.title, '
        'error_count = excluded.error_count, error_msg = excluded.error_msg,'
        'icon_url = excluded.icon_url,'
        'category_id = excluded.category_id,'
        'hide_globally = excluded.hide_globally'
    );
    await customStatement(buffer.toString(), args);
  }

}