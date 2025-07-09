


import 'package:get/get.dart';

class FeedPickerController extends GetxController {

  final RxList<BigInt> feeds;

  final List<BigInt> initialFeeds;
  FeedPickerController({required this.initialFeeds})
      : feeds = initialFeeds.obs;

  void change(String id) {
    final feedId = BigInt.parse(id);
    if (feeds.contains(feedId)){
      feeds.remove(feedId);
    } else {
      feeds.add(feedId);
    }
  }

}