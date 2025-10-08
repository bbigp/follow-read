

import 'package:follow_read/core/utils/api_result.dart';
import 'package:follow_read/core/utils/http_client.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/page_info.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/providers/miniflux/entry_page_response.dart';
import 'package:follow_read/data/providers/miniflux/feed_response.dart';
import 'package:follow_read/features/data/models/add_feed_response.dart';

import 'me_response.dart';

class MinifluxApi {

  static Future<ApiResult<User>> me({required String baseUrl,
    required String token,
  }) async {
    ApiResult<MeResponse> result = await HttpClient.get(
      "me", MeResponseMapper.fromMap,
      baseUrl: baseUrl, token: token
    );
    return result.map((meResp) => meResp.toUser(token: token, baseUrl: baseUrl));
  }

  static Future<ApiResult<PageInfo<Entry>>> entries({
    int page = 1, int size = 10, List<String> statuses = const ["unread", "read", "removed"],
    String order = "changed_at", String direction = "desc",
  }) async {
    ApiResult<EntryPageResponse> result = await HttpClient.get("entries", query: {
      'limit': size, 'offset': (page -1) * size,
      'status': statuses,
      'order': order, 'direction': direction,
      'globally_visible': false,
    }, EntryPageResponseMapper.fromMap);
    return result.map((resp) => resp.toPageInfo());
  }

  static Future<ApiResult<BigInt>> postFeed(String url, BigInt folderId) async {
    final result = await HttpClient.post("feeds", AddFeedResponseMapper.fromMap, data: {
      'feed_url': url,
      'category_id': folderId,
    });
    return result.map((resp) => resp.feedId);
  }

  static Future<ApiResult<Feed>> getFeed(BigInt feedId) async {
    final result = await HttpClient.get("feeds/$feedId", FeedResponseMapper.fromMap,);
    return result.map((resp) => resp.toFeed());
  }

  static Future<ApiResult<Feed>> putFeed(BigInt feedId, {String? title, BigInt? folderId}) async {
    final result =  await HttpClient.put("feeds/$feedId", FeedResponseMapper.fromMap, data: {
      'title': title,
      'category_id': folderId,
    });
    return result.map((resp) => resp.toFeed());
  }

  static Future<ApiResult<EmptyObject>> removeFeed(BigInt feedId) async {
    return await HttpClient.delete('feeds/$feedId', (v) => EmptyObject());
  }

  static Future<ApiResult<EmptyObject>> setEntryStatus(List<BigInt> entryIds, EntryStatus status) async {
    return await HttpClient.put("entries", (v) => EmptyObject(), data: {
      'entry_ids': entryIds,
      'status': status.name
    });
  }




}


class EmptyObject {}

