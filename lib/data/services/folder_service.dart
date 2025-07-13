

import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/feed_dao.dart';
import 'package:follow_read/data/repositories/folder_dao.dart';
import 'package:follow_read/data/services/service_base.dart';

class FolderService extends ServiceBase implements MetaRow {

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

  @override
  Future<List<Entry>> entries(Meta meta, {int? page, int? size}) async {
    final folder = meta as Folder;
    final feedIds = folder.feeds.map((e) => e.id).toList();
    final entries = await _entryDao.entries(
      feedIds: feedIds,
      statuses: folder.statuses,
      order: folder.order,
      page: page, size: size,
    );
    final feedMap = Map.fromEntries(
        folder.feeds.map((e) => MapEntry(e.id, e))
    );
    return entries.map((e) => e.copyWith(feed: feedMap[e.feedId])).toList();
  }

}