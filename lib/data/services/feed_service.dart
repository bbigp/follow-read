

import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/repositories/feed_dao.dart';

import 'service_base.dart';

class FeedService extends ServiceBase {

  late final FeedDao _feeDao;

  @override
  void onInit() {
    super.onInit();
    _feeDao = FeedDao(db);
  }

  Future<List<Feed>> getAllFeeds() async {
    return await _feeDao.getAllFeeds();
  }

}