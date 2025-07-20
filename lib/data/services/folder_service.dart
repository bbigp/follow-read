

import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/feed_dao.dart';
import 'package:follow_read/data/repositories/folder_dao.dart';
import 'package:follow_read/data/services/service_base.dart';

class FolderService extends ServiceBase {

  late final FolderDao _dao;
  late final EntryDao _entryDao;
  late final FeedDao _feedDao;

  @override
  void onInit() {
    super.onInit();
    _dao = FolderDao(db);
    _entryDao = EntryDao(db);
    _feedDao = FeedDao(db);
  }

  Future<List<Folder>> getAllFolders() async {
    return await _dao.getAllFolders();
  }

}