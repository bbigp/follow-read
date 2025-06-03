import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/feedhub/feedhub_controller.dart';
import 'package:follow_read/features/presentation/providers/folderhub/folderhub_controller.dart';
import 'package:get/get.dart';

import 'add_feed_state.dart';

class AddFeedController extends GetxController {
  final AddFeedState state = AddFeedState();
  final feedhub = Get.find<FeedhubController>();
  final folderhub = Get.find<FolderhubController>();

  final int feedId;
  AddFeedController(this.feedId);


  @override
  void onInit() {
    super.onInit();
    state.folder = feedhub.state.rootFolder;
    if (feedId == 0) return;
    state.feed = feedhub.getById(feedId);
    if (state.feed.id <= 0) return;
    state.stateFeedUrl.value = state.feed.feedUrl;
    state.stateFeedTitle.value = state.feed.title;
    state.folder = folderhub.getById(state.feed.categoryId);
  }

  void changed({String? title, String? url, Category? newFolder}) {
    if (title != null) {
      state.stateFeedTitle.value = title;
    }
    if (url != null) {
      state.stateFeedUrl.value = url;
    }
    if (newFolder != null){
      state.folder = newFolder;
    }
  }

  Future<bool> save() async {
    if (!state.isEditing) {
      var success = await feedRepository.saveFeed(state.stateFeedUrl.value, state.folder.id);
      if (success) {
        // ref.read(syncProvider.notifier).startSync();
        return true;
      }
      return false;
    }
    var success = await feedRepository.updateFeed(state.feed.id, state.stateFeedTitle.value, state.folder.id);
    await feedhub.init();
    return success;
  }

}
