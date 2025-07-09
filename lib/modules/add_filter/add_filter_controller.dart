

import 'package:get/get.dart';

class AddFilterController extends GetxController{

  final BigInt id;
  AddFilterController(this.id);
  final state = AddFilterState();

  @override
  void onReady() {
    super.onReady();
  }

  void change({String? icon, String? title, List<String>? statuses,
    int? releaseTime, int? addTime, List<int>? feedIds,
  }){
    if (icon != null) {
      state._icon.value = icon;
    }
    if (title != null) {
      state._title.value = title;
    }
    if (releaseTime != null) {
      state._releaseTime.value = releaseTime;
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

}

class AddFilterState {

  final _icon = "".obs;
  String get icon => _icon.value;

  final _title = "".obs;
  String get title => _title.value;

  final feedIds = <int>[].obs;

  final _releaseTime = 0.obs;
  int get releaseTime => _releaseTime.value;

  final _addTime = 0.obs;
  int get addTime => _addTime.value;

  final statuses = <String>[].obs;


  Map<int, String> timeMap = {
    0: 'Off',
    1440: '最近24小时',
    2880: '最近48小时',
    10080: '最近一周',
    40320: '最近一个月'
  };
}