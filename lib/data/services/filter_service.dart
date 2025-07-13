

import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/feed_dao.dart';
import 'package:follow_read/data/repositories/filter_dao.dart';
import 'package:follow_read/data/services/service_base.dart';

class FilterService extends ServiceBase implements MetaRow {

  late final FilterDao _dao;
  late final EntryDao _entryDao;
  late final FeedDao _feedDao;

  @override
  void onInit() {
    super.onInit();
    _dao = FilterDao(db);
    _entryDao = EntryDao(db);
    _feedDao = FeedDao(db);
  }

  Future<void> save(Filter f) async {
    await _dao.save(f);
  }

  Future<List<Filter>> getAllFilters() async {
    return await _dao.getAllFilters();
  }


  Future<bool> deleteById(BigInt id) async {
    return await _dao.deleteById(id);
  }

  @override
  Future<List<Entry>> entries(Meta meta, {int? page, int? size}) async {
    final filter = meta as Filter;
    final entries = await _entryDao.entries(feedIds: filter.feedIds,
      statuses: filter.statuses, publishedTime: filter.publishedTime, addTime: filter.addTime,
      page: page, size: size, order: filter.order,
    );
    final feedMap = Map.fromEntries(
        filter.feeds.map((e) => MapEntry(e.id, e))
    );
    return entries.map((e) => e.copyWith(feed: feedMap[e.feedId])).toList();
  }

}