import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class FeedhubState {
  FeedhubState();

  List<Feed> feeds = [];
  List<Feed> get rootFeeds => feedMap[rootFolderId] ?? [];

  final stateLen = 0.obs;
  int get len => stateLen.value;
  set len(int length) => stateLen.value = length;

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

  final int rootFolderId = 1;



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
