import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class AddFeedState {
  AddFeedState();

  final Rx<Category> stateFolder = Category.empty.obs;
  Category get folder => stateFolder.value;

  Feed feed = Feed.empty;

  final stateFeedUrl = "".obs;
  String get feedUrl => stateFeedUrl.value;

  final stateFeedTitle = "".obs;
  String get feedTitle => stateFeedTitle.value;
}
