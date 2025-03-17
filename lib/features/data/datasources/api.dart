import 'package:flutter/cupertino.dart';

import '../../domain/models/feed.dart';
import '../models/entry.dart';
import '../../../core/utils/http_service.dart';
import '../../../core/utils/logger.dart';

class Api {

  static Future<void> getMe({
    required ValueSetter<List<Feed>> onSuccess,
    required ValueSetter<String> onError,}) async {
    try {
      final response = await HttpService.get("me");
      if (response.success) {
        
        return;
      }
      onError(response.error ?? '失败');
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future<void> getFeedsAndCounters({
    required ValueSetter<List<Feed>> onSuccess,
    required ValueSetter<String> onError,
  }) async {
    try {
      // 并行调用两个 API
      final results = await Future.wait([
        HttpService.get('feeds'),
        HttpService.get('feeds/counters'),
      ]);

      // 提取结果
      final feedsResponse = results[0];
      final countersResponse = results[1];

      // 处理第一个 API 的返回值
      if (!feedsResponse.success) {
        onError(feedsResponse.error ?? '获取订阅源失败');
        return;
      }
      // final List<dynamic> feedsJson = feedsResponse.data as List<dynamic>;
      // final feeds = feedsJson
      //     .map((json) => Feed.fromJson(json as Map<String, dynamic>))
      //     .toList();
      //
      // if (countersResponse.success) {
      //     final counter = FeedCounter.fromJson(countersResponse.data as Map<String, dynamic>);
      //     final fs = feeds.map((f) => f.copyWith(read: counter.reads[f.id.toString()], unread: counter.unreads[f.id.toString()])).toList();
      //     onSuccess(fs);
      //     return;
      // }
      logger.e("获取订阅源计数器失败$countersResponse.error");
      // onSuccess(feeds);
    } catch (e) {
      logger.e("getFeedsAndCounters: $e");
      onError(e.toString());
    }
  }


  static Future<void> getEntries({
    required int feedId,
    required int page,
    required int limit,
    required ValueSetter<List<Entry>> onSuccess,
    required ValueSetter<String> onError,
    VoidCallback? onComplete,
  }) async {
    try {
      //status order  direction   limit  offset  category_id  feed_id  tags globally_visible
      final response = await HttpService.get('feeds/$feedId/entries?limit=$limit&offset=${(page - 1) * limit}');
      if (response.success) {
        onSuccess(EntryResponse.fromJson(response.data as Map<String, dynamic>).entries);
      } else {
        onError(response.error ?? '获取订阅源失败');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      onComplete?.call();
    }
  }


  static Future<void> getFeeds({
    required ValueSetter<List<Feed>> onSuccess,
    required ValueSetter<String> onError,
    VoidCallback? onComplete,
  }) async {
    try {
      // final response = await HttpService.get('feeds');
      // if (response.success) {
      //   final List<dynamic> feedsJson = response.data as List<dynamic>;
      //   final feeds = feedsJson
      //       .map((json) => Feed.fromJson(json as Map<String, dynamic>))
      //       .toList();
      //   onSuccess(feeds);
      // } else {
      //   onError(response.error ?? '获取订阅源失败');
      // }
    } catch (e) {
      onError(e.toString());
    } finally {
      onComplete?.call();
    }
  }

  // static Future<void> getFeedsCounters({
  //   required ValueSetter<FeedCounter> onSuccess,
  //   required ValueSetter<String> onError,
  //   VoidCallback? onComplete,
  // }) async {
  //   try {
  //     final response = await HttpService.get('feeds/counters');
  //     if (response.success) {
  //       final Map<String, dynamic> counter = response.data as Map<String, dynamic>;
  //       onSuccess(FeedCounter.fromJson(counter));
  //     } else {
  //       onError(response.error ?? '获取订阅源未读数失败');
  //     }
  //   } catch (e) {
  //     onError(e.toString());
  //   } finally {
  //     onComplete?.call();
  //   }
  // }

  // static Future<void> getFeedIcon({
  //   required int iconId,
  //   required ValueSetter<FeedIcon> onSuccess,
  //   required ValueSetter<String> onError,
  //   VoidCallback? onComplete,
  // }) async {
  //   try {
  //     final response = await HttpService.get('icons/$iconId', headers: {
  //       'Content-Type': 'application/json',
  //       'X-Auth-Token': 'lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600='
  //     });
  //     if (response.success) {
  //       final icon = FeedIcon.fromJson(response.data as Map<String, dynamic>);
  //       onSuccess(icon);
  //     } else {
  //       onError(response.error ?? '获取订阅源失败');
  //     }
  //   } catch (e) {
  //     onError(e.toString());
  //   } finally {
  //     onComplete?.call();
  //   }
  // }



}
