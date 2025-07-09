

import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final state = ProfileState();

  final userService = Get.find<UserService>();
  final _cache = Get.find<MemoryCacheController>();

  @override
  void onInit() {
    super.onInit();
    state._stateUser.value = userService.getUser();
    state._rootFolder.value = _cache.getFolder(state.user.rootFolderId) ?? Folder(title: "None");
  }


  void change({bool? autoRead, String? unreadMark, String? openContent,
    BigInt? rootFolderId,
  }) async {
    await userService.save(autoRead: autoRead, unreadMark: unreadMark,
      openContent: openContent, rootFolderId: rootFolderId,
    );
    onInit();
  }

}

class ProfileState {

  final _stateUser = User.empty.obs;
  User get user => _stateUser.value;

  final _rootFolder = Folder().obs;
  Folder get rootFolder => _rootFolder.value;

}