

import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/repositories/folder_dao.dart';
import 'package:follow_read/data/services/service_base.dart';

class FolderService extends ServiceBase {

  late final FolderDao _dao;

  @override
  void onInit() {
    super.onInit();
    _dao = FolderDao(db);
  }

  Future<List<Folder>> getAllFolders() async {
    return await _dao.getAllFolders();
  }


}