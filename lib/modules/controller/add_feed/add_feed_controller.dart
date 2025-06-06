import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/modules/controller/home/home_controller.dart';
import 'package:get/get.dart';

import 'add_feed_state.dart';


class AddFeedController extends GetxController {
  final AddFeedState state = AddFeedState();
  final _home = Get.find<HomeController>();


  final int feedId;
  AddFeedController(this.feedId);

  @override
  void onReady() {
    super.onReady();
    _load();
  }


  Future<void> _load() async {
    final rootFolderId = 1;
    if (feedId != 0) {
      final feed = await feedRepository.getFeedById(feedId);
      state.feed = feed;
      state.stateFeedTitle.value = feed.title;
      state.stateFeedUrl.value = feed.feedUrl;
      state.stateFolder.value = await folderRepository.getCategoryById(feed.categoryId);
      return;
    }
    state.stateFolder.value = await folderRepository.getCategoryById(rootFolderId);
  }



  void changed({String? title, String? url, Category? newFolder}) {
    if (title != null) {
      state.stateFeedTitle.value = title;
    }
    if (url != null) {
      state.stateFeedUrl.value = url;
    }
    if (newFolder != null){
      state.stateFolder.value = newFolder;
    }
  }

  Future<bool> save() async {
    if (feedId <= 0) {
      var success = await feedRepository.saveFeed(state.stateFeedUrl.value, state.folder.id);
      if (success) {
        // ref.read(syncProvider.notifier).startSync();
      }
      return success;
    }
    var success = await feedRepository.updateFeed(state.feed.id, state.stateFeedTitle.value, state.folder.id);
    await _home.init();
    return success;
  }

}
