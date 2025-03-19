

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:follow_read/features/data/models/entry_page_response.dart';

import '../../../core/utils/failure.dart';
import '../../../core/utils/follow_request.dart';
import '../models/feed_counter_response.dart';
import '../models/feed_response.dart';
import '../models/user_response.dart';
import '../../../core/utils/http_utils.dart';

class ApiClient {
  static final httpUtil = HttpUtil();

  static Future<Either<Failure, UserResponse>> me(
      {required String baseUrl,
      required String token,}) async {
    return await httpUtil.safeRequest<UserResponse>(
      path: httpUtil.buildPath(baseUrl, "me"),
      method: HttpMethod.get,
      fromJson: (json) => UserResponseMapper.fromJson(json),
      headers: httpUtil.buildHeaders(httpUtil.defaultHeaders, token),
    );
  }

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

  static Future<Either<Failure, EntryPageResponse>> getEntries(int feedId, {
    int page = 1, int size = 10,
  }) async {
    return await httpUtil.safeRequest(
        path: 'feeds/$feedId/entries',
        method: HttpMethod.get,
        queryParams: {
          'limit': size, 'offset': (page -1) * size,
          'status': 'unread',
          'order': 'published_at',//"id", "status", "changed_at", "published_at", "created_at", "category_title", "category_id", "title", "author"
          'direction': 'desc', //desc asc
          // 'category_id': null,
          // 'feed_id': feedId,
          // 'tags': null,
          'globally_visible': false,
        },
        fromJson: (json) => EntryPageResponseMapper.fromJson(json)
    );
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