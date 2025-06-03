

import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

import 'app_container.dart';
import 'feeds_controller.dart';

class FoldersController extends GetxController {
  final feedsController = Get.find<FeedsController>();

  final RxList<Category> folders = <Category>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<Category> root = Category.empty.obs;


  Future<void> init() async {
    if (isLoading.value) return;
    isLoading.value = true;
    final list = await folderRepository.getCategories();
    root.value = list.firstWhere((c) => c.title == "All", orElse: () => Category.empty);

    void treeFeed(){
      List<Category> f = [];
      for (final item in list) {
        if (item.id == root.value.id){
          continue;
        }
        f.add(item.copyWith(feeds: feedsController.folderFeedsMap[item.id] ?? []));
      }
      folders.assignAll(f);
    }
    treeFeed();
    ever(feedsController.feeds, (_) => treeFeed());
    isLoading.value = false;
  }


}