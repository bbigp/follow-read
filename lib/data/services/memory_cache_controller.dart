


import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';

class MemoryCacheController extends GetxService {

  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final _userService = Get.find<UserService>();

  final Map<BigInt, Feed> _feedMap = {};
  final Map<BigInt, Folder> _folderMap = {};

  final _feedLen = 0.obs;
  int get feedLen => _feedLen.value;
  final _folderLen = 0.obs;
  int get folderLen => _folderLen.value;
  final _user = User.empty.obs;
  User get user => _user.value;

  Future<MemoryCacheController> load() async {
    final feeds = await _feedService.getAllFeeds();
    final folders = await _folderService.getAllFolders();

    _feedLen.value = feeds.length;
    _folderLen.value = folders.length;

    _feedMap
      ..clear()
      ..addEntries(feeds.map((f) => MapEntry(f.id, f)));

    _folderMap
      ..clear()
      ..addEntries(folders.map((f) => MapEntry(f.id, f)));
    return this;
  }

  Feed? getFeed(BigInt id) => _feedMap[id];
  Folder? getFolder(BigInt id) => _folderMap[id];
  List<Feed> get feeds => _feedMap.values.toList();
  List<Folder> get folders => _folderMap.values.toList();

}