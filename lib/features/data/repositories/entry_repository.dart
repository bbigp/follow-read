
import 'package:follow_read/features/data/datasources/entities/entry_entity.dart';
import 'package:follow_read/features/data/datasources/entities/feed_entity.dart';
import 'package:follow_read/features/data/datasources/entry_dao.dart';
import 'package:follow_read/features/data/datasources/feed_dao.dart';
import 'package:follow_read/features/data/models/entry_page_response.dart';
import 'package:follow_read/features/domain/models/entry.dart';

import '../datasources/api_client.dart';

class EntryRepository {
  final EntryDao _dao;
  final FeedDao _feedDao;
  EntryRepository({required EntryDao dao, required FeedDao feedDao,})
      : _dao = dao, _feedDao = feedDao ;

  Future<List<Entry>> getEntries(int feedId, int page, int size) async {
    final result = await ApiClient.getEntries(feedId, page: page, size: size);
    return result.fold((failure) async {
      return [];
    }, (data) async {
      await _dao.bulkInsertWithTransaction(data.entries.map((item) => item.toCompanion()).toList());
      return data.entries.map((item) => item.toModel()).toList();
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
    }, (data) {
      return data.toModel();
    });
  }

}