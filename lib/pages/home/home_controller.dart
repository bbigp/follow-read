import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:get/get.dart';

import '../../../../pages/home/home_state.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();

  Future<void> init() async {
    if (state.isLoading) return;
    // 设置里 选择设置root folder  config query root folder id
    state.isLoading = true;
    final rawFolders = await folderRepository.getCategories();
    final root = rawFolders.firstWhere((c) => c.id == 1, orElse: () => Category.empty);

    final rawFeeds = await feedRepository.getFeeds();
    state.feedMap = rawFeeds.fold<Map<int, List<Feed>>>(
      {},
          (map, feed) {
        final cid = feed.categoryId;
        map.putIfAbsent(cid, () => []);
        map[cid]!.add(feed);
        return map;
      },
    );

    state.folders = rawFolders
        .where((item) => item.id != root.id)
        .map((item) => item.copyWith(
      feeds: state.feedMap[item.id] ?? [],
    )).toList();
    state.stateFolderLen.value = state.folders.length;

    state.feeds = state.feedMap[root.id] ?? [];
    state.stateFeedLen.value = state.feeds.length;

    state.artiads = await artiadRepository.getAll();
    state.stateArtiadLen.value = state.artiads.length;

    state.isLoading = false;
  }


  void expanded(int id){
    final index = state.folders.indexWhere((c) => c.id == id);
    if (index == -1) {
      return;
    }
    final current = state.folders[index];
    final updated = current.copyWith(expanded: !current.expanded);
    state.folders[index] = updated;
    update(['folder_tile:$index']);
  }

}
