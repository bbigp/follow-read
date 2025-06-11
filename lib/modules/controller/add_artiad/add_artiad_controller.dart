import 'package:get/get.dart';

import 'add_artiad_state.dart';

class AddArtiadController extends GetxController {
  final AddArtiadState state = AddArtiadState();
  final int id;
  AddArtiadController(this.id);

  @override
  void onReady() {
    super.onReady();
    _load();
  }

  Future<void> _load() async {

  }

  void change({String? icon, String? title, List<String>? statuses,
    int? releaseTime, int? addTime, List<int>? feedIds,
  }){
    if (icon != null) {
      state.stateIcon.value = icon;
    }
    if (title != null) {
      state.stateTitle.value = title;
    }
    if (releaseTime != null) {
      state.stateReleaseTime.value = releaseTime;
    }
    if (addTime != null) {
      state.stateAddTime.value = addTime;
    }
    if (statuses != null) {
      state.statuses.value = statuses;
    }
    if (feedIds != null) {
      state.feedIds.value = feedIds;
    }
  }

}
