

import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/feed_dao.dart';
import 'package:follow_read/data/repositories/filter_dao.dart';
import 'package:follow_read/data/services/service_base.dart';

class FilterService extends ServiceBase {

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

  Future<Filter?> getFilter(BigInt id) async {
    return await _dao.getFilter(id);
  }


  Future<bool> deleteById(BigInt id) async {
    return await _dao.deleteById(id);
  }

}