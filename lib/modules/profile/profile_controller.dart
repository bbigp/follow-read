

import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final state = ProfileState();

  final userService = Get.find<UserService>();
  final folderService = Get.find<FolderService>();
  final _cache = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    final user = userService.getUser();
    state._stateUser.value = user;
  }

  @override
  void onReady() {
    super.onReady();
    loading();
  }

  void loading() async {
    state._rootFolder.value = await folderService.getFolder(state.user.rootFolderId) ?? Folder(title: "None");
  }


  void change({bool? autoRead, String? unreadMark, String? openContent,
    BigInt? rootFolderId,
  }) async {
    await userService.save(autoRead: autoRead, unreadMark: unreadMark,
      openContent: openContent, rootFolderId: rootFolderId,
    );
    onInit();
    onReady();
    await _cache.loadHomeData(loadAll: true);
  }

}

class ProfileState {

  final _stateUser = User.empty.obs;
  User get user => _stateUser.value;

  final _rootFolder = Folder(title: "None").obs;
  Folder get rootFolder => _rootFolder.value;

}