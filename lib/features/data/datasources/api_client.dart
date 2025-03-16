

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/failure.dart';
import '../../../core/utils/follow_request.dart';
import '../../domain/models/user.dart';
import '../models/feed_response.dart';
import '../models/user_response.dart';
import '../../../core/utils/http_utils.dart';

class ApiClient {
  static final httpUtil = HttpUtil();

  static Map<String, String> _setAuthorization(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Auth-Token': token,
    };
  }

  static Future<Either<Failure, UserResponse>> me(
      {required String baseUrl,
      required String token,}) async {
    return await httpUtil.safeRequest<UserResponse>(
      path: _path(baseUrl, "me"),
      method: HttpMethod.get,
      fromJson: (json) => UserResponseMapper.fromJson(json),
      headers: _setAuthorization(token),
    );
  }

  static Future<Either<Failure, List<FeedResponse>>> getFeeds() async {
    final (baseUrl, token) = await _getAuthInfo();
    return await httpUtil.safeRequest<List<FeedResponse>>(
      path: _path(baseUrl, 'feeds'),
      method: HttpMethod.get,
      fromJson: (json) {
        final list = jsonDecode(json) as List<dynamic>;
        final feeds = list
            .map((json) => FeedResponseMapper.fromMap(json))
            .toList();
        return feeds;
      },
      headers: _setAuthorization(token),
    );
  }

  static String _path(String baseUrl, String path) {
    if (baseUrl.endsWith("/")) {
      return baseUrl + path;
    }
    return "$baseUrl/$path";
  }


  static Future<(String, String)> _getAuthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('cachedUser');
    if (json == null) {
      return ("", "");
    }
    final user = UserMapper.fromJson(jsonDecode(json));
    return (user.baseUrl, user.token);
  }


}
