
import 'dart:convert';

import '../models/user.dart';
import 'http_utils.dart';
import 'logger.dart';


class ApiClient {

  static final httpUtil = HttpUtil();


  static Future<User?> me({Function(ApiException)? onError}) async {
    httpUtil.setAuthorization('lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600=');
    return await httpUtil.safeRequest<User>(
      path: 'me',
      method: HttpMethod.get,
      fromJson: (json) => User.fromJson(json),
      onError: onError,
    );
  }

}






