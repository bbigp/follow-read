//
//
// import 'package:follow_read/features/data/datasources/cluster_dao.dart';
// import 'package:follow_read/features/data/datasources/entities/entry_entity.dart';
// import 'package:follow_read/features/data/datasources/entities/feed_entity.dart';
// import 'package:follow_read/features/data/datasources/entry_dao.dart';
// import 'package:follow_read/features/data/datasources/feed_dao.dart';
// import 'package:follow_read/features/data/models/entry_page_response.dart';
// import 'package:follow_read/features/data/repositories/feed_repository.dart';
// import 'package:follow_read/features/domain/models/entry.dart';
// import 'package:follow_read/features/domain/models/sync_task.dart';
// import 'package:follow_read/modules/pages/entries/meta_data.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../core/utils/logger.dart';
// import '../datasources/api_client.dart';
//
// class EntryRepository {
//   final EntryDao _dao;
//   final FeedDao _feedDao;
//   final FeedRepository _feedRepository;
//   final ClusterDao _clusterDao;
//   EntryRepository({required EntryDao dao, required FeedDao feedDao,
//   required FeedRepository feedRepository,
//   required ClusterDao clusterDao,
//   })
//       : _dao = dao, _feedDao = feedDao,
//         _feedRepository = feedRepository,
//       _clusterDao = clusterDao;
//
//   Future<int> syncProcess() async{
//     try {
//       final cacheTotal = await _dao.count();
//       final total = await getTotal();
//       return total - cacheTotal;
//     } catch (e) {
//       (await SharedPreferences.getInstance()).setString(SyncTask.status, SyncTask.failed);
//     }
//     return -1;
//   }
//
//
//   Future<bool> syncEntries(void Function(String, int) onProgress) async {
//     int size = 50;
//     try {
//       await _feedRepository.refreshFeeds();
//       final String? maxTime = (await SharedPreferences.getInstance()).getString(SyncTask.progress);
//       bool isFullSync = maxTime == null || maxTime.isEmpty;
//       int totalSynced = 0;
//
//       if (isFullSync) {
//         int page = 1;
//         while(true) {
//           final entries = await getAndSave(page: page, size: size, direction: "asc");
//           totalSynced += entries.length;
//           onProgress(SyncTask.syncing, totalSynced);
//           if (entries.isEmpty) break;
//           page++;
//         }
//       } else {
//         DateTime max = DateTime.parse(maxTime);
//         int page = 1;
//         while (true) {
//           final entries = await getAndSave(page: page, size: size, direction: "desc");
//           totalSynced += entries.length;
//           onProgress(SyncTask.syncing, totalSynced);
//           if (entries.isEmpty) break;
//           if(entries.isNotEmpty) {
//             final time = entries[entries.length - 1].changedAt;
//             if (time.isAtSameMomentAs(max) || time.isBefore(max)) break;
//             logger.i('${max.toString()} ${entries[entries.length - 1].changedAt.toString()}');
//           }
//           page++;
//         }
//       }
//       final newMaxTime = await _dao.getMaxChangedAt();
//       (await SharedPreferences.getInstance()).setString(SyncTask.status, SyncTask.success);
//       (await SharedPreferences.getInstance()).setString(SyncTask.progress, newMaxTime.toString());
//       onProgress(SyncTask.success, 0);
//       return true;
//     } catch (e) {
//       logger.e("同步数据失败 $e");
//       (await SharedPreferences.getInstance()).setString(SyncTask.status, SyncTask.failed);
//       onProgress(SyncTask.failed, 0);
//       return false;
//     } finally {
//       (await SharedPreferences.getInstance()).setString(SyncTask.executeTime, DateTime.now().toString());
//     }
//   }
//
//   Future<List<EntryResponse>> getAndSave({required int page, required int size, required String direction,
//     int maxRetries = 3, int retryDelaySeconds = 3,
//   }) async {
//     int attempt = 0;
//     Object? lastError;
//     while (attempt <= maxRetries) {
//       attempt++;
//       try {
//         final result = await ApiClient.getEntries(page: page, size: size, order: "changed_at", direction: direction,
//             status: ["unread", "read", "removed"]);
//         return result.fold((failure) {
//           if (attempt > maxRetries) {
//             throw Exception('达到最大重试次数: $lastError'); // 触发外层catch
//           }
//           throw failure; // 触发重试
//         }, (data) async {
//           await saveAndReturnData(data.entries, needReturn: false);
//           return data.entries;
//         });
//       } catch (e) {
//         lastError = e;
//         if (attempt > maxRetries) {
//           logger.e('[Page $page] 终止请求，已重试 $maxRetries 次');
//           throw Exception('最终失败: $lastError'); // 向外抛出错误
//         }
//         logger.e('[Page $page] $retryDelaySeconds秒后重试...');
//         await Future.delayed(Duration(seconds: retryDelaySeconds));
//       }
//     }
//     throw StateError('Unreachable code'); // 理论上不会执行
//   }
//
//
//   Future<int> getTotal({String direction = "desc"}) async {
//     final result = await ApiClient.getEntries(page: 1, size: 1, order: "changed_at", direction: direction,
//         status: ["unread", "read", "removed"]);
//     return result.fold((failure) {
//       throw Exception('达到最大重试次数: $failure'); // 触发外层catch
//     }, (data) async {
//       return data.total;
//     });
//   }
//

//

//
//   Future<List<Entry>> saveAndReturnData(List<EntryResponse> list, {bool needReturn = true}) async {
//     if (list.isEmpty) {
//       return [];
//     }
//     await _dao.bulkInsertWithTransaction(list.map((item) => item.toCompanion()).toList());
//     if (!needReturn) {
//       return [];
//     }
//     final entryIds = list.map((item) => item.id).toList();
//     final entries = await _dao.getAllEntriesByIds(entryIds);
//
//     final feedIds = list.map((e) => e.feedId).toSet().toList();
//     final feeds = await _feedDao.getFeedsByIds(feedIds);
//     final feedMap = {for (var feed in feeds) feed.id: feed};
//
//     return entries.map((entry) {
//       final feed = feedMap[entry.feedId];
//       if (feed != null) {
//         return entry.toModel().copyWith(feed: feed.toModel());
//       }
//       return entry.toModel();
//     }).toList();
//   }
//
//
//   Future<bool> starred(int entryId, bool starred) async {
//     final result = await ApiClient.starred(entryId);
//     return result.fold((_){
//       return false;
//     }, (_) async {
//       await _dao.updateStatus(entryId, starred: starred);
//       return true;
//     });
//   }
//
//
//   Future<Entry> getEntry(int entryId) async {
//     final entry = await _dao.getEntry(entryId);
//     if (entry != null) {
//       final re = entry.toModel();
//       final feed = await _feedDao.getFeed(re.feedId);
//       return re.copyWith(feed: feed.toModel());
//     }
//     final result = await ApiClient.getEntry(entryId);
//     return result.fold((failure) {
//       return Entry(id: 0, title: '', hash: '');
//     }, (data) async{
//       final list = await saveAndReturnData([data]);
//       return list[0];
//     });
//   }

//
// }
//
//
// // final stopwatch = Stopwatch();
// // stopwatch.start();
// // final result = await ApiClient.getEntriesByFeedId(feedId, page: page, size: size, status: status);
// // stopwatch.stop();
// // final requestTime = stopwatch.elapsedMilliseconds;
// // logger.i('🕒 网络请求耗时: ${requestTime}ms');
// // return result.fold((failure) async {
// // return [];
// // }, (data) async {
// // stopwatch.reset();
// // stopwatch.start();
// // final savedEntries = await saveAndReturnData(data.entries);
// // stopwatch.stop();
// // final saveTime = stopwatch.elapsedMilliseconds;
// // logger.i('💾 数据库保存耗时: ${saveTime}ms');
// // logger.i('⏱️ 总耗时: ${requestTime + saveTime}ms');
// // return savedEntries;
// // });