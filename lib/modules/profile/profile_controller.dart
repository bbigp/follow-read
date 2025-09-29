

import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxService {
  final state = ProfileState();

  final userService = Get.find<UserService>();
  final folderService = Get.find<FolderService>();
  bool isInitialized = true;
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    final user = userService.getUser();
    state._stateUser.value = user;
    state._unreadMark.value = user.unreadMark;
    if (isInitialized) {//onInit的时候先设置rootFolder，保证home controller能正常加载数据
      state._rootFolder.value = Folder(id: user.rootFolderId);
      // _box.listenKey(PrefsKeys.unreadMark, (v) {
      //   state._unreadMark.value = UnreadMark.fromString(v);
      // });
      isInitialized = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    loading();
  }

  void loading() async {
    state._rootFolder.value = await folderService.getFolder(state.user.rootFolderId) ?? Folder(title: "None");
  }


  Future<void> change({bool? autoRead, String? unreadMark, String? openContent,
    BigInt? rootFolderId,
  }) async {
    await userService.save(autoRead: autoRead, unreadMark: unreadMark,
      openContent: openContent, rootFolderId: rootFolderId,
    );
    onInit();
    onReady();
  }

}

class ProfileState {

  final _stateUser = User.empty.obs;
  User get user => _stateUser.value;

  final _unreadMark = UnreadMark.dot.obs;
  UnreadMark get unreadMark => _unreadMark.value;

  final _rootFolder = Folder(title: "None").obs;
  Folder get rootFolder => _rootFolder.value;

}