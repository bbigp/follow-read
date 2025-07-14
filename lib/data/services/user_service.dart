

import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/providers/miniflux/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserService extends GetxService {

  final _box = GetStorage();

  Future<bool> login(String baseUrl, String token, {
    void Function()? onSuccess,
    void Function(String error)? onError
  }) async {
    final result = await MinifluxApi.me(baseUrl: baseUrl, token: token);
    if (!result.success) {
      onError?.call(result.message);
      return false;
    }
    await _box.write(PrefsKeys.userId, result.data!.id);
    await _box.write(PrefsKeys.username, result.data!.username);
    await _box.write(PrefsKeys.baseUrl, result.data!.baseUrl);
    await _box.write(PrefsKeys.token, result.data!.token);
    onSuccess?.call();
    return true;
  }

  Future<void> save({bool? autoRead, String? unreadMark, String? openContent,
    BigInt? rootFolderId
  }) async {
    if (autoRead != null) {
      await _box.write(PrefsKeys.autoRead, autoRead);
    }
    if (unreadMark != null) {
      await _box.write(PrefsKeys.unreadMark, unreadMark);
    }
    if (openContent != null) {
      await _box.write(PrefsKeys.openContent, openContent);
    }
    if (rootFolderId != null) {
      await _box.write(PrefsKeys.rootFolderId, rootFolderId.toString());
    }
  }

  User getUser() {
    final rootFolderIdStr = _box.read<String>(PrefsKeys.rootFolderId);
    final rootFolderId = BigInt.parse(rootFolderIdStr ?? '0');
    return User(
      id: _box.read<int>(PrefsKeys.userId) ?? 0,
      username: _box.read(PrefsKeys.username).toString(),
      baseUrl: _box.read(PrefsKeys.baseUrl).toString(),
      token: _box.read(PrefsKeys.token).toString(),
      autoRead: _box.read<bool>(PrefsKeys.autoRead) ?? false,
      unreadMark: UnreadMark.fromString(_box.read<String>(PrefsKeys.unreadMark) ?? "Dot"),
      openContent: _box.read<String>(PrefsKeys.openContent) ?? "内置阅读器",
      rootFolderId: rootFolderId,
    );
  }

}