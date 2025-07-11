

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:follow_read/features/data/models/add_feed_response.dart';
import 'package:follow_read/features/data/models/entry_page_response.dart';

import '../../../core/utils/failure.dart';
import '../../../core/utils/follow_request.dart';
import '../models/feed_counter_response.dart';
import '../models/feed_response.dart';
import '../../../core/utils/http_utils.dart';

class ApiClient {
  static final httpUtil = HttpUtil();



  static Future<Either<Failure, FeedCounterResponse>>  getFeedCounters() async {
    return await httpUtil.safeRequest(
        path: 'feeds/counters',
        method: HttpMethod.get,
        fromJson: (json) => FeedCounterResponse.fromJson(jsonDecode(json)),
    );
  }

  static Future<Either<Failure, List<FeedResponse>>> getFeeds() async {
    return await httpUtil.safeRequest<List<FeedResponse>>(
      path: 'feeds',
      method: HttpMethod.get,
      fromJson: (json) {
        final list = jsonDecode(json) as List<dynamic>;
        final feeds = list
            .map((json) => FeedResponseMapper.fromMap(json))
            .toList();
        return feeds;
      },
    );
  }

  static Future<Either<Failure, AddFeedResponse>> saveFeed(String url, int categoryId) async {
    return await httpUtil.safeRequest(
        path: 'feeds',
        body: {
          'feed_url': url,
          'category_id': categoryId,
        },
        method: HttpMethod.post,
        fromJson: (json) => AddFeedResponseMapper.fromJson(json),
    );
  }

  static Future<Either<Failure, FeedResponse>> updateFeed(int feedId,
      String title, int categoryId) async {
    return await httpUtil.safeRequest(
      path: 'feeds/$feedId',
      body: {
        'title': title,
        'category_id': categoryId,
      },
      method: HttpMethod.put,
      fromJson: (json) => FeedResponseMapper.fromJson(json),
    );
  }

  static Future<Either<Failure, Success>> removeFeed(int feedId) async {
    return await httpUtil.safeRequest(
        path: 'feeds/$feedId',
        method: HttpMethod.delete,
        fromJson: (json) => Success.fromJson(json)
    );
  }

  static Future<Either<Failure, EntryPageResponse>> getEntriesByFeedId(int feedId, {
    int page = 1, int size = 10, List<String> status = const ["unread"],
    String order = "published_at", String direction = "desc",
  }) async {
    return await httpUtil.safeRequest(
        path: 'feeds/$feedId/entries' ,
        method: HttpMethod.get,
        queryParams: {
          'limit': size, 'offset': (page -1) * size,
          'status': status,
          'order': order,//"id", "status", "changed_at", "published_at", "created_at", "category_title", "category_id", "title", "author"
          'direction': direction, //desc asc
          // 'category_id': null,
          // 'feed_id': feedId,
          // 'tags': null,
          'globally_visible': false,
        },
        fromJson: (json) => EntryPageResponseMapper.fromJson(json)
    );
  }


  static Future<Either<Failure, EntryPageResponse>> getEntries({
    int page = 1, int size = 10, List<String> status = const ["unread", "read", "removed"],
    String order = "changed_at", String direction = "asc",
  }) async {
    return await httpUtil.safeRequest(path: 'entries', method: HttpMethod.get,
        queryParams: {
          'limit': size, 'offset': (page -1) * size, 'status': status, 'order': order,
          'direction': direction, 'globally_visible': false,
        },
        fromJson: (json) => EntryPageResponseMapper.fromJson(json)
    );
  }

  static Future<Either<Failure, EntryResponse>> getEntry(int entryId) async {
    return await httpUtil.safeRequest(path: 'entries/$entryId',
        method: HttpMethod.get,
        fromJson: (json) => EntryResponseMapper.fromJson(json));
  }

  //'unread' read removed
  static Future<Either<Failure, Success>> putEntry(int entryId, String status) async {
    return await httpUtil.safeRequest(
        path: 'entries',
        method: HttpMethod.put,
        body: {
          'entry_ids': [entryId],
          'status': status
        },
        fromJson: (json) => Success.fromJson(json)
    );
  }

  static Future<Either<Failure, Success>> starred(int entryId) async {
    return await httpUtil.safeRequest(
        path: 'entries/$entryId/bookmark',
        method: HttpMethod.put,
        fromJson: (json) => Success.fromJson(json)
    );
  }




}
class Success {
  final bool success;

  Success(this.success);

  factory Success.fromJson(String json) {
    return Success(true);
  }
}

// extension QueryParamConversion on dynamic {
//   String toQueryParam() {
//     if (this == null) return '';
//     if (this is String) return this as String;
//     if (this is bool) return this ? 'true' : 'false';
//     return toString();
//   }
// }