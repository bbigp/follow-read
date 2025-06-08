import 'package:follow_read/features/domain/models/feed.dart';
import 'package:get/get.dart';

class FeedsState {
  FeedsState();

  RxList<Feed> feeds = <Feed>[].obs;

  final stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;
}
