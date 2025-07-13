

import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/providers/miniflux/api.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/feed_dao.dart';

import 'service_base.dart';

class FeedService extends ServiceBase implements MetaRow{

  late final FeedDao _feeDao;
  late final EntryDao _entryDao;

  @override
  void onInit() {
    super.onInit();
    _feeDao = FeedDao(db);
    _entryDao = EntryDao(db);
  }

  Future<List<Feed>> getAllFeeds() async {
    return await _feeDao.getAllFeeds();
  }


  Future<bool> save(String feedUrl, BigInt folderId) async {
    final result = await MinifluxApi.postFeed(feedUrl, folderId);
    if (result.success) {
      final feedId = result.data!;
      final feedResult = await MinifluxApi.getFeed(feedId);
      await _feeDao.batchSave([feedResult.data!]);
    }
    return result.success;
  }

  Future<bool> updateFeed(BigInt feedId, {String? title, BigInt? folderId}) async {
    final result = await MinifluxApi.putFeed(feedId, title: title, folderId: folderId);
    if (result.success) {
      await _feeDao.batchSave([result.data!]);
    }
    return result.success;
  }

  @override
  Future<List<Entry>> entries(Meta meta, {int? page, int? size}) async {
    final feed = meta as Feed;
    final statuses = feed.onlyShowUnread ? [EntryState.unread.name] : [EntryState.unread.name, EntryState.read.name];
    final entries = await _entryDao.entries(feedIds: [feed.id], statuses: statuses,
      order: feed.order,
      page: page, size: size,
    );
    return entries.map((e) => e.copyWith(feed: feed)).toList();
  }


}