

import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

import 'app_container.dart';

class FoldersController extends GetxController {

  final RxList<Category> folders = <Category>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> init() async {
    if (isLoading.value) return;
    isLoading.value = true;
    final f = await folderRepository.getCategories();
    folders.assignAll(f);
    isLoading.value = false;
  }

}