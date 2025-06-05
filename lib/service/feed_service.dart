import 'package:dartz/dartz.dart';
import 'package:follow_read/core/utils/failure.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/data/datasources/api_client.dart';
import 'package:follow_read/features/data/datasources/category_dao.dart';
import 'package:follow_read/features/data/datasources/entities/feed_entity.dart';
import 'package:follow_read/features/data/datasources/entry_dao.dart';
import 'package:follow_read/features/data/datasources/feed_dao.dart';
import 'package:follow_read/features/data/models/feed_response.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/service/user_service.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FeedService extends GetxService {

  final FeedDao feedDao = Get.find<FeedDao>();
  final CategoryDao categoryDao = Get.find<CategoryDao>();
  final EntryDao entryDao = Get.find<EntryDao>();
  final UserService userService = Get.find<UserService>();

  FeedService();

  Future<Either<Failure, List<Feed>>> refreshFeeds() async {
    final result = await ApiClient.getFeeds();
    final user = userService.getCurrentUser();
    String baseUrl = user.baseUrl;
      return await result.fold((failure) async => Left(failure),
            (feedResponse) async {
          await feedDao.bulkInsertWithTransaction(feedResponse.map((item) => item.toCompanion(baseUrl)).toList());
          final categories = feedResponse.map((item) => item.category).toSet().toList();
          await categoryDao.bulkInsertWithTransaction(categories.map((item) => item.toCompanion()).toList());
          return Right(await getFeeds(showAll: true));
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

  Future<List<Feed>> getFeedsByCategoryId(int categoryId) async {
    return (await feedDao.getFeedsByCategoryId(categoryId)).map((item) => item.toModel()).toList();
  }

  Future<bool> updateShow(int feedId, {bool? onlyShowUnread,
    bool? showReadingTime, String? orderx, bool? hideGlobally, }) async {
    return await feedDao.updateShow(feedId, onlyShowUnread: onlyShowUnread,
      showReadingTime: showReadingTime,
      orderx: orderx, hideGlobally: hideGlobally,
    );
  }

  Future<List<Feed>> getFeeds({bool showAll = true, List<int>? ids}) async {
    final feeds = await feedDao.getAllFeeds(showAll: showAll, ids: ids);
    logger.i('查询到本地feeds: ${feeds.length}');
    return feeds.map((e) => e.toModel()).toList();
  }

  Future<bool> saveFeed(String feedUrl, int categoryId) async {
    final result = await ApiClient.saveFeed(feedUrl, categoryId);
    return await result.fold((ifLeft) => false, (ifRight) => true);
  }

  Future<bool> updateFeed(int feedId, String title, int categoryId) async {
    final result = await ApiClient.updateFeed(feedId, title, categoryId);
    var success = result.fold((ifLeft) => false, (ifRight) => true);
    if (success) {
      return await feedDao.updateShow(feedId, title: title, categoryId: categoryId);
    }
    return false;
  }

  Future<bool> removeFeed(int feedId) async {
    var either = await ApiClient.removeFeed(feedId);
    var success = either.fold((_) => false, (ifRight) => true);
    if (success) {
      await feedDao.deleteById(feedId);
      await entryDao.deleteByFeedId(feedId);
      return true;
    }
    return false;
  }



}