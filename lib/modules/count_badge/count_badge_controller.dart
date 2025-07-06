import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';


class CountBadgeController extends GetxController {
  final state = CountBadgeState();

  final userService = Get.find<UserService>();

  @override
  void onReady() {
    super.onReady();

    state._countMap.value = <String, int>{};
  }

}


class CountBadgeState {

  final _stateUnreadMark = UnreadMark.none.obs;
  UnreadMark get unreadMark => _stateUnreadMark.value;

  final RxMap<String, int> _countMap = <String, int>{}.obs;
  int getValue(String key) => _countMap[key] ?? 0;
}