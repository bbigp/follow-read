import 'package:flutter/cupertino.dart';

import '../models/feed.dart';
import '../models/icon.dart';
import '../utils/http_service.dart';

class Api {
  static Future<void> getFeeds({
    required ValueSetter<List<Feed>> onSuccess,
    required ValueSetter<String> onError,
    VoidCallback? onComplete,
  }) async {
    try {
      final response = await HttpService.get('feeds', headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': 'lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600='
      });
      if (response.success) {
        final List<dynamic> feedsJson = response.data as List<dynamic>;
        final feeds = feedsJson
            .map((json) => Feed.fromJson(json as Map<String, dynamic>))
            .toList();
        onSuccess(feeds);
      } else {
        onError(response.error ?? '获取订阅源失败');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      onComplete?.call();
    }
  }

  static Future<void> getFeedIcon({
    required int iconId,
    required ValueSetter<FeedIcon> onSuccess,
    required ValueSetter<String> onError,
    VoidCallback? onComplete,
  }) async {
    try {
      final response = await HttpService.get('icons/$iconId', headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': 'lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600='
      });
      if (response.success) {
        final icon = FeedIcon.fromJson(response.data as Map<String, dynamic>);
        onSuccess(icon);
      } else {
        onError(response.error ?? '获取订阅源失败');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      onComplete?.call();
    }
  }



}
