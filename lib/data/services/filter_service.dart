

import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/repositories/filter_dao.dart';
import 'package:follow_read/data/services/service_base.dart';

class FilterService extends ServiceBase {

  late final FilterDao _dao;

  @override
  void onInit() {
    super.onInit();
    _dao = FilterDao(db);
  }

  Future<void> save(Filter f) async {
    logger.i('dsds ${f.name}');
    await _dao.save(f);
  }

  Future<List<Filter>> getAllFilters() async {
    return await _dao.getAllFilters();
  }

}