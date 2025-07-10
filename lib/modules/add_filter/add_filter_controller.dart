

import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:get/get.dart';

class AddFilterController extends GetxController{

  final BigInt id;
  AddFilterController(this.id);
  final state = AddFilterState();
  final _cache = Get.find<MemoryCacheController>();
  final _filterService = Get.find<FilterService>();

  @override
  void onReady() {
    super.onReady();
    if (id != BigInt.zero) {
      state._filter = _cache.getFilter(id) ?? Filter();
      state._icon.value = state._filter.icon;
      state._title.value = state._filter.name;
      state._publishedTime.value = state._filter.publishedTime;
      state._addTime.value = state._filter.addTime;
      state.feedIds.value = state._filter.feedIds;
      state.statuses.value = state._filter.statuses;
    }
  }



  void change({String? icon, String? title, List<String>? statuses,
    int? publishedTime, int? addTime, List<BigInt>? feedIds,
  }){
    if (icon != null) {
      state._icon.value = icon;
    }
    if (title != null) {
      state._title.value = title;
    }
    if (publishedTime != null) {
      state._publishedTime.value = publishedTime;
    }
    if (addTime != null) {
      state._addTime.value = addTime;
    }
    if (statuses != null) {
      state.statuses.value = statuses;
    }
    if (feedIds != null) {
      state.feedIds.value = feedIds;
    }
  }

  Future<void> save() async{
    await _filterService.save(state._filter.copyWith(name: state.title, icon: state.icon,
      publishedTime: state.publishedTime, addTime: state.addTime,
      feedIds: state.feedIds, statuses: state.statuses,
    ));
    await _cache.load();
  }

}

class AddFilterState {

  Filter _filter = Filter();

  final _icon = "".obs;
  String get icon => _icon.value;

  final _title = "".obs;
  String get title => _title.value;

  final _publishedTime = 0.obs;
  int get publishedTime => _publishedTime.value;

  final _addTime = 0.obs;
  int get addTime => _addTime.value;

  final feedIds = <BigInt>[].obs;
  final statuses = <String>[].obs;


  Map<int, String> timeMap = {
    0: 'Off',
    1440: '最近24小时',
    2880: '最近48小时',
    10080: '最近一周',
    40320: '最近一个月'
  };
}