import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class AddFeedState {
  AddFeedState();

  final stateFeedUrl = "".obs;
  String get feedUrl => stateFeedUrl.value;

  final stateFeedTitle = "".obs;

  final Rx<Feed> stateFeed = Feed.empty.obs;
  Feed get feed => stateFeed.value;
  set feed(Feed f) => stateFeed.value = f;

  final Rx<Category> stateFolder = Category.empty.obs;
  Category get folder => stateFolder.value;
  set folder(Category f) => stateFolder.value = f;



  bool get isEditing => feed.id > 0;


}
