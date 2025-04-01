
import 'package:dartz/dartz.dart';
import 'package:follow_read/features/data/datasources/category_dao.dart';
import 'package:follow_read/features/data/datasources/entities/feed_entity.dart';
import 'package:follow_read/features/data/datasources/feed_dao.dart';
import 'package:follow_read/features/data/models/feed_response.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import '../../../core/utils/failure.dart';
import '../../../core/utils/logger.dart';
import '../datasources/api_client.dart';
import '../datasources/local_data.dart';

class FeedRepository {

  final FeedDao feedDao;
  final LocalData localData;
  final CategoryDao categoryDao;

  FeedRepository({required this.feedDao, required this.localData, required this.categoryDao});

  Future<Either<Failure, List<Feed>>> refreshFeeds() async {
    final result = await ApiClient.getFeeds();
    final user = await localData.getCachedUser();
    String baseUrl = "";
    if (user != null) {
      baseUrl = user.baseUrl;
    }
    return await result.fold((failure) async => Left(failure),
            (feedResponse) async {
          await feedDao.bulkInsertWithTransaction(feedResponse.map((item) => item.toCompanion(baseUrl)).toList());
          final categories = feedResponse.map((item) => item.category).toSet().toList();
          await categoryDao.bulkInsertWithTransaction(categories.map((item) => item.toCompanion()).toList());
          return Right(await getFeeds());
        });
  }

  Future<void> refreshFeedCounter() async {
    final result = await ApiClient.getFeedCounters();
    result.fold((failure) {}, (counter) async {
        await feedDao.bulkUpdateCounter(counter.toConters());
    });
  }

  Future<Feed> getFeedById(int feedId) async {
    return (await feedDao.getFeedById(feedId)).toModel();
  }

  Future<bool> updateShow(int feedId, {bool? onlyShowUnread, bool? showReadingTime}) async {
    return await feedDao.updateShow(feedId, onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime);
  }

  Future<List<Feed>> getFeeds() async {
    final feeds = await feedDao.getAllFeeds();
    logger.i('查询到本地feeds: ${feeds.length}');
    return feeds.map((e) => e.toModel()).toList();
  }

}