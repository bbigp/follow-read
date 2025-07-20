

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





  static Future<Either<Failure, Success>> removeFeed(int feedId) async {
    return await httpUtil.safeRequest(
        path: 'feeds/$feedId',
        method: HttpMethod.delete,
        fromJson: (json) => Success.fromJson(json)
    );
  }



  static Future<Either<Failure, EntryResponse>> getEntry(int entryId) async {
    return await httpUtil.safeRequest(path: 'entries/$entryId',
        method: HttpMethod.get,
        fromJson: (json) => EntryResponseMapper.fromJson(json));
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