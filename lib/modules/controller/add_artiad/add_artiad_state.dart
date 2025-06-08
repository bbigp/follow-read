import 'package:get/get.dart';

class AddArtiadState {
  AddArtiadState();

  final stateIcon = "".obs;
  String get icon => stateIcon.value;

  final stateTitle = "".obs;
  String get title => stateTitle.value;

  final feedIds = <int>[].obs;

  final stateReleaseTime = 0.obs;
  int get releaseTime => stateReleaseTime.value;

  final stateAddTime = 0.obs;
  int get addTime => stateAddTime.value;

  final statuses = <String>[].obs;


  Map<int, String> timeMap = {
    0: 'Off',
    1440: '最近24小时',
    2880: '最近48小时',
    10080: '最近一周',
    40320: '最近一个月'
  };
}
