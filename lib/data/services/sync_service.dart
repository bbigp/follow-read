


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

  Future<void> sync() async {
    await _box.write(PrefsKeys.isSyncing, true);
    int page = 1;
    int size = 25;
    final now = DateTime.now();
    DateTime localMaxTime = now.add(Duration(days: -365));
    final record = SyncRecord(time: now, status: "run", startTime: localMaxTime, endTime: now);
    final id = await _syncRecordDao.save(record);
    Map<BigInt, Feed> feedMap = {};
    Map<BigInt, Folder> folderMap = {};
    List<Media> medias = [];
    int entry = 0;
    while(true) {
      var result = await MinifluxApi.entries(page: page, size: size);
      if (!result.success) {
        await _syncRecordDao.updateFinish(id, 'fail', errorMsg: result.message, entry: entry);
        await _box.write(PrefsKeys.isSyncing, false);
        return;
      }

      var entries = result.data?.list;
      if (entries == null || entries.isEmpty) {
        break;
      }

      entry += entries.length;
      for (var e in entries) {
        feedMap[e.feedId] = e.feed;
        folderMap[e.folder.id] = e.folder;
        medias.addAll(e.medias);
      }
      await _entryDao.bulkInsertWithTransaction(entries);
      var minTime = entries.last.changedAt;
      if (entries.length < size || minTime.isBefore(localMaxTime)) {
        break;
      }
      page++;
    }

    final feeds = feedMap.values.toList();
    await _feeDao.batchSave(feeds);
    final folders = folderMap.values.toList();
    await _folderDao.batchSave(folders);
    await _mediaDao.batchSave(medias);
    await _syncRecordDao.updateFinish(id, 'ok', entry: entry,
        feed: feeds.length, folder: folders.length, media: medias.length,
    );
    await _box.write(PrefsKeys.isSyncing, false);
  }

}