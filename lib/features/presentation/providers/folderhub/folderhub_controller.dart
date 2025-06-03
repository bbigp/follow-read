import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/feedhub/feedhub_controller.dart';
import 'package:get/get.dart';

import 'folderhub_state.dart';

class FolderhubController extends GetxController {
  final FolderhubState state = FolderhubState();
  final feedhub = Get.find<FeedhubController>();

  Future<void> init() async {
    if (state.isLoading) return;
    state.isLoading = true;
    final rawFolders = await folderRepository.getCategories();

    void rebuild(){
      state.rootFolder = feedhub.state.rootFolder;
      List<Category> updated = rawFolders
          .where((item) => item.id != state.rootFolder.id)
          .map((item) => item.copyWith(
        feeds: feedhub.state.feedMap[item.id] ?? [],
      )).toList();
      state.folders.assignAll(updated);
    }

    rebuild();
    ever(feedhub.state.stateFeeds, (_) => rebuild());
    state.isLoading = false;
  }

  Category getById(int id){
    if (id == state.rootFolder.id) {
      return state.rootFolder;
    }
    return state.folders.firstWhere((c) => c.id == id, orElse: () => Category.empty);
  }

}
