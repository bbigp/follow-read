

import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';

import 'service_base.dart';

class EntryService extends ServiceBase {

  late final EntryDao _dao;

  @override
  void onInit() {
    super.onInit();
    _dao = EntryDao(db);
  }


  Future<Map<BigInt, int>> countFeed() async {
    return await _dao.countFeed();
  }

  Future<Map<BigInt, int>> countFilter(List<Filter> filters) async {
    return await _dao.countFilter(filters);
  }

}