
import 'package:dartz/dartz.dart';
import 'package:follow_read/features/data/datasources/entities/feed_entity.dart';
import 'package:follow_read/features/data/datasources/feed_dao.dart';
import 'package:follow_read/features/data/models/feed_response.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import '../../../core/utils/failure.dart';
import '../../../core/utils/logger.dart';
import '../datasources/api_client.dart';
import '../datasources/local_data.dart';

class FeedRepository {

  final FeedDao _feedDao;
  final LocalData _localData;

  FeedRepository({required FeedDao feedDao, required LocalData localData})
      : _feedDao = feedDao, _localData = localData;

  Future<Either<Failure, List<Feed>>> refreshFeeds() async {
    final result = await ApiClient.getFeeds();
    final user = await _localData.getCachedUser();
    String baseUrl = "";
    if (user != null) {
      baseUrl = user.baseUrl;
    }
    return await result.fold((failure) async => Left(failure),
            (feedResponse) async {
          await _feedDao.bulkInsertWithTransaction(feedResponse.map((item) => item.toCompanion(baseUrl)).toList());
          return Right(await getFeeds());
        });
  }

  Future<void> refreshFeedCounter() async {
    final result = await ApiClient.getFeedCounters();
    result.fold((failure) {}, (counter) async {
        await _feedDao.bulkUpdateCounter(counter.toConters());
    });
  }

  Future<Feed> getFeedById(int feedId) async {
    return (await _feedDao.getFeedById(feedId)).toModel();
  }

  Future<bool> updateShow(int feedId, {bool? onlyShowUnread, bool? showReadingTime}) async {
    return await _feedDao.updateShow(feedId, onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime);
  }

  Future<List<Feed>> getFeeds() async {
    final feeds = await _feedDao.getAllFeeds();
    logger.i('查询到本地feeds: ${feeds.length}');
    return feeds.map((e) => e.toModel()).toList();
  }

}