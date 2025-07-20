

import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/providers/miniflux/api.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/media_dao.dart';
import 'package:follow_read/modules/widgets/me/me.dart';

import 'service_base.dart';

class EntryService extends ServiceBase {

  late final EntryDao _dao;
  late final MediaDao _mediaDao;

  @override
  void onInit() {
    super.onInit();
    _dao = EntryDao(db);
    _mediaDao = MediaDao(db);
  }


  Future<Map<BigInt, int>> countFeed() async {
    return await _dao.countFeed();
  }

  Future<Map<BigInt, int>> countFilter(List<Filter> filters) async {
    return await _dao.countFilter(filters);
  }

  Future<Entry> getEntry(BigInt id) async {
    return await _dao.getEntry(id);
  }


  Future<List<Entry>> entries(Meta meta, {int? page, int? size}) async {
    var feedIds = <BigInt>[];
    var statuses = <String>[];
    var order = "";
    int? publishedTime;
    int? addTime;
    var feedMap = <BigInt, Feed>{};
    if (meta is Feed) {
      statuses = meta.statuses;
      order = meta.order;
      feedIds.add(meta.id);
      feedMap[meta.id] = meta;
    } else if (meta is Folder) {
      statuses = meta.statuses;
      order = meta.order;
      feedIds = meta.feeds.map((e) => e.id).toList();
      feedMap = Map.fromEntries(
          meta.feeds.map((e) => MapEntry(e.id, e))
      );
    } else if (meta is Filter) {
      statuses = meta.statuses;
      order = meta.order;
      feedIds = meta.feedIds;
      feedMap = Map.fromEntries(
          meta.feeds.map((e) => MapEntry(e.id, e))
      );
      publishedTime = meta.publishedTime;
      addTime = meta.addTime;
    }

    final entries = await _dao.entries(feedIds: feedIds, statuses: statuses,
      publishedTime: publishedTime, addTime: addTime,
      order: order,
      page: page, size: size,
    );
    final mediaMap = await _mediaDao.mediaMapByEntryIds(entries.map((e) => e.id).toList());
    return entries.map((e) => e.copyWith(feed: feedMap[e.feedId], medias: mediaMap[e.id])).toList();
  }


  Future<bool> setEntryStatus(List<BigInt> entryIds, EntryStatus status) async {
    final result = await MinifluxApi.setEntryStatus(entryIds, status);
    if (result.success) {
      await _dao.updateStatus(entryIds, status);
    }
    return result.success;
  }

}