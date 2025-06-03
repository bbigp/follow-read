import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class FeedhubState {
  FeedhubState();

  final RxList<Feed> stateFeeds = <Feed>[].obs;
  List<Feed> get feeds => stateFeeds;

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

  final Rx<Category> stateRootFolder = Category.empty.obs;
  Category get rootFolder => stateRootFolder.value;
  set rootFolder(Category f) => stateRootFolder.value = f;

  List<Feed> get rootFeeds => feedMap[rootFolder.id] ?? [];

  Map<int, List<Feed>> get feedMap => feeds.fold<Map<int, List<Feed>>>(
    {},
        (map, feed) {
      final cid = feed.categoryId;
      map.putIfAbsent(cid, () => []);
      map[cid]!.add(feed);
      return map;
    },
  );


}
