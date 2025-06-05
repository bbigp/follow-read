import 'package:get/get.dart';

import 'home_state.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();


  Future<void> init() async {
    state.rootFolder = await folderRepository.getByName(Model.rootFolderName);

    await feedRepository.getFeeds()

    if (state.isLoading) return;
    state.isLoading = true;
    final rawFolders = await folderRepository.getCategories();
    // 设置里 选择设置root folder  config query root folder id

    void rebuild(){
      state.rootFolder = rawFolders.firstWhere((c) => c.id == 1, orElse: () => Category.empty);
      state.folders = rawFolders
          .where((item) => item.id != state.rootFolder.id)
          .map((item) => item.copyWith(
        feeds: feedhub.state.feedMap[item.id] ?? [],
      )).toList();
    }

    rebuild();
    // ever(feedhub.state.stateFeeds, (_) => rebuild());
    state.isLoading = false;

    state.aists.assignAll(await aistRepository.getAll());

  }


}
