
import 'package:follow_read/features/data/datasources/entities/entry_entity.dart';
import 'package:follow_read/features/data/datasources/entities/feed_entity.dart';
import 'package:follow_read/features/data/datasources/entry_dao.dart';
import 'package:follow_read/features/data/datasources/feed_dao.dart';
import 'package:follow_read/features/data/models/entry_page_response.dart';
import 'package:follow_read/features/domain/models/entry.dart';

import '../../../core/utils/logger.dart';
import '../datasources/api_client.dart';

class EntryRepository {
  final EntryDao _dao;
  final FeedDao _feedDao;
  EntryRepository({required EntryDao dao, required FeedDao feedDao,})
      : _dao = dao, _feedDao = feedDao ;


  Future<void> syncEntries(int feedId) async {

    await ApiClient.getEntries(feedId, page: 1, size: 10, order: "changed_at", direction: "asc",
        status: ["unread", "read", "removed"]);


  }



  Future<List<Entry>> getEntries(int feedId, int page, {int size = 10, bool onlyShowUnread = false}) async {
    List<String> status = onlyShowUnread ? ["unread"] : ["unread", "read"];
    final stopwatch = Stopwatch();
    stopwatch.start();
    final result = await ApiClient.getEntries(feedId, page: page, size: size, status: status);
    stopwatch.stop();
    final requestTime = stopwatch.elapsedMilliseconds;
    logger.i('🕒 网络请求耗时: ${requestTime}ms');
    return result.fold((failure) async {
      return [];
    }, (data) async {
      stopwatch.reset();
      stopwatch.start();
      final savedEntries = await saveAndReturnData(data.entries);
      stopwatch.stop();
      final saveTime = stopwatch.elapsedMilliseconds;
      logger.i('💾 数据库保存耗时: ${saveTime}ms');
      logger.i('⏱️ 总耗时: ${requestTime + saveTime}ms');
      return savedEntries;
    });
  }

  Future<List<Entry>> getEntriesByFeedId(int feedId) async {
    final entrys = await _dao.getEntriesByFeedId(feedId);
    final feedIds = entrys.map((e) => int.parse(e.feedId.toString())).toSet().toList();
    final feeds = await _feedDao.getFeedsByIds(feedIds);
    final feedMap = {for (var feed in feeds) feed.id: feed};
    return entrys.map((entry) {
      final feed = feedMap[entry.feedId];
      if (feed != null) {
        return entry.toModel().copyWith(feed: feed.toModel());
      }
      return entry.toModel();
    }).toList();
  }

  Future<List<Entry>> saveAndReturnData(List<EntryResponse> list) async {
    if (list.isEmpty) {
      return [];
    }
    await _dao.bulkInsertWithTransaction(list.map((item) => item.toCompanion()).toList());

    final entryIds = list.map((item) => item.id).toList();
    final entrys = await _dao.getAllEntriesByIds(entryIds);

    final feedIds = list.map((e) => e.feedId).toSet().toList();
    final feeds = await _feedDao.getFeedsByIds(feedIds);
    final feedMap = {for (var feed in feeds) feed.id: feed};

    return entrys.map((entry) {
      final feed = feedMap[entry.feedId];
      if (feed != null) {
        return entry.toModel().copyWith(feed: feed.toModel());
      }
      return entry.toModel();
    }).toList();
  }

  Future<bool> updateStatus(int entryId, String status) async {
    final result = await ApiClient.putEntry(entryId, status);
    return result.fold((_){
      return false;
    }, (_) async {
      await _dao.updateStatus(entryId, status: status);
      return true;
    });
  }

  Future<bool> starred(int entryId, bool starred) async {
    final result = await ApiClient.starred(entryId);
    return result.fold((_){
      return false;
    }, (_) async {
      await _dao.updateStatus(entryId, starred: starred);
      return true;
    });
  }


  Future<Entry> getEntry(int entryId) async {
    final entry = await _dao.getEntry(entryId);
    if (entry != null) {
      final re = entry.toModel();
      final feed = await _feedDao.getFeed(re.feedId);
      return re.copyWith(feed: feed.toModel());
    }
    final result = await ApiClient.getEntry(entryId);
    return result.fold((failure) {
      return Entry(id: 0, title: '', hash: '');
    }, (data) async{
      final list = await saveAndReturnData([data]);
      return list[0];
    });
  }

}