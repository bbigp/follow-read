import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:get/get.dart';

import 'feedhub_state.dart';

class FeedhubController extends GetxController {
  final FeedhubState state = FeedhubState();

  Future<void> init() async {
    if (state.isLoading) return;
    state.isLoading = true;
    state.rootFolder = await folderRepository.getByName(Model.rootFolderName);
    state.feeds.assignAll(await feedRepository.getFeeds());
    state.isLoading = false;
  }

  Feed getById(int id) {
    return state.feeds.firstWhere((c) => c.id == id, orElse: () => Feed.empty);
  }
}
