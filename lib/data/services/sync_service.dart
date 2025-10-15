


import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/media.dart';
import 'package:follow_read/data/model/sync_record.dart';
import 'package:follow_read/data/providers/miniflux/api.dart';
import 'package:follow_read/data/repositories/entry_dao.dart';
import 'package:follow_read/data/repositories/feed_dao.dart';
import 'package:follow_read/data/repositories/folder_dao.dart';
import 'package:follow_read/data/repositories/media_dao.dart';
import 'package:follow_read/data/repositories/sync_record_dao.dart';
import 'package:follow_read/di.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SyncService extends GetxService {

  late final FeedDao _feeDao;
  late final SyncRecordDao _syncRecordDao;
  late final FolderDao _folderDao;
  late final EntryDao _entryDao;
  late final MediaDao _mediaDao;
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    final db = Get.find<DBService>().db;
    _feeDao = FeedDao(db);
    _folderDao = FolderDao(db);
    _syncRecordDao = SyncRecordDao(db);
    _entryDao = EntryDao(db);
    _mediaDao = MediaDao(db);
  }

  bool getState(){
    return _box.read<bool>(PrefsKeys.isSyncing) ?? false;
  }

  Future<List<SyncRecord>> syncRecords(int page, {int size = 20}) async {
    return await _syncRecordDao.getSyncRecords(page, size: size);
  }

  Future<DateTime?> getLastSyncTime() async {
    return await _syncRecordDao.getLastSyncTime();
  }

  Future<void> sync() async {
    await _box.write(PrefsKeys.isSyncing, true);
    int page = 1;
    int size = 25;
    final now = DateTime.now();
    DateTime localMaxTime = await _entryDao.getMaxTime();
    final record = SyncRecord(time: now, status: "run", startTime: localMaxTime, endTime: now);
    final id = await _syncRecordDao.save(record);
    int entryCount = 0;
    int mediaCount = 0;
    int feedCount = 0;
    int folderCount = 0;
    try {
      List<BigInt> savedFeedIds = [];
      List<BigInt> savedFolderIds = [];
      while (true) {
        var result = await MinifluxApi.entries(page: page, size: size, direction: "asc");
        if (!result.success) {
          throw Exception(result.message);
        }

        var entries = result.data?.list;
        if (entries == null || entries.isEmpty) {
          break;
        }

        List<Media> medias = [];
        List<Feed> feeds = [];
        List<Folder> folders = [];
        for (var e in entries) {
          if (!savedFeedIds.contains(e.feedId)) {
            feeds.add(e.feed);
          }
          if (!savedFolderIds.contains(e.folder.id)) {
            folders.add(e.folder);
          }
          medias.addAll(e.medias);
        }
        entryCount += entries.length;
        mediaCount += medias.length;
        feedCount += feeds.length;
        folderCount += folders.length;
        await _entryDao.bulkInsertWithTransaction(entries);
        await _mediaDao.batchSave(medias);
        await _feeDao.batchSave(feeds);
        await _folderDao.batchSave(folders);
        medias.clear();
        feeds.clear();
        folders.clear();
        if (entries.length < size) {
          break;
        }
        page++;
      }
      await _syncRecordDao.updateFinish(id, 'ok',
        entry: entryCount, feed: feedCount, folder: folderCount, media: mediaCount,
      );
    } catch(e) {
      await _syncRecordDao.updateFinish(
          id, 'fail', errorMsg: e.toString (),
        entry: entryCount, media: mediaCount, feed: feedCount, folder: folderCount,
      );
    } finally {
      await _box.write(PrefsKeys.isSyncing, false);
    }
  }

}