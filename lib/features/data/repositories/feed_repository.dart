
import 'package:dartz/dartz.dart';
import 'package:follow_read/features/data/datasources/entities/feed_entity.dart';
import 'package:follow_read/features/data/datasources/feed_dao.dart';
import 'package:follow_read/features/data/models/feed_response.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import '../../../core/utils/failure.dart';
import '../../../core/utils/logger.dart';
import '../datasources/api_client.dart';

class FeedRepository {

  final FeedDao _feedDao;

  FeedRepository({required FeedDao feedDao}) : _feedDao = feedDao;

  Future<Either<Failure, List<Feed>>> refreshFeeds() async {
    final result = await ApiClient.getFeeds();
    return await result.fold((failure) async => Left(failure),
            (feedResponse) async {
          await _feedDao.bulkInsertWithTransaction(feedResponse.map((item) => item.toCompanion()).toList());
          final feeds = feedResponse.map((item) => item.toModel()).toList();
          return Right(feeds);
        });
  }

  Future<void> refreshFeedCounter() async {
    final result = await ApiClient.getFeedCounters();
    result.fold((failure) {}, (counter) async {
        await _feedDao.bulkUpdateCounter(counter.toConters());
    });
  }

  Future<List<Feed>> getFeeds() async {
    final feeds = await _feedDao.getAllFeeds();
    logger.i('查询到本地feeds: ${feeds.length}');
    return feeds.map((e) => e.toModel()).toList();
  }

}