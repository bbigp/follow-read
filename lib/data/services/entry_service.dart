

import 'package:follow_read/data/model/constant.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/model/pending_change.dart';
import 'package:follow_read/data/providers/miniflux/api.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/media_dao.dart';
import 'package:follow_read/data/repositories/pending_change_dao.dart';

import 'service_base.dart';

class EntryService extends ServiceBase {

  late final EntryDao _dao;
  late final MediaDao _mediaDao;
  late final PendingChangeDao _pendingChangeDao;

  @override
  void onInit() {
    super.onInit();
    _dao = EntryDao(db);
    _mediaDao = MediaDao(db);
    _pendingChangeDao = PendingChangeDao(db);
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


  Future<List<Entry>> entries(Meta meta, {int? page, int? size, String? search}) async {
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

    if (search != null && search != "") {
      statuses = [];
      order = Model.orderPublishedAt;
      publishedTime = null;
      addTime = null;
    }

    final entries = await _dao.entries(feedIds: feedIds, statuses: statuses,
      publishedTime: publishedTime, addTime: addTime,
      order: order,
      page: page, size: size, search: search,
    );
    final mediaMap = await _mediaDao.mediaMapByEntryIds(entries.map((e) => e.id).toList());
    return entries.map((e) => e.copyWith(feed: feedMap[e.feedId], medias: mediaMap[e.id])).toList();
  }

  Future<bool> updateById(BigInt entryId, {String? readableContent, String? summary, String? leadImageUrl}) async {
    return await _dao.updateById(entryId, readableContent: readableContent,
        summary: summary, leadImageUrl: leadImageUrl,
    );
  }


  Future<bool> setEntryStatus(List<BigInt> entryIds, BigInt userId, {
    EntryStatus? status, bool? starred,
  }) async {
    await db.transaction(() async {
      for (var entryId in entryIds) {
        PendingChangeAction? action;
        if (status != null) {
          action = status.toPendingAction();
        }
        if (starred != null) {
          action = starred ? PendingChangeAction.starred : PendingChangeAction.unstarred;
        }
        await _pendingChangeDao.save(entryId.toString(), userId: userId, action: action!);
      }
      await _dao.updateStatus(entryIds, status: status, starred: starred);
    });
    // final result = await MinifluxApi.setEntryStatus(entryIds, status);
    return true;
  }

}