
import 'dart:convert';

import '../models/user_model.dart';
import '../../../core/utils/http_utils.dart';
import '../../../core/utils/logger.dart';


class ApiClient {

  static final httpUtil = HttpUtil();


  static Future<UserModel?> me({Function(ApiException)? onError}) async {
    httpUtil.setAuthorization('lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600=');
    return await httpUtil.safeRequest<UserModel>(
      path: 'me',
      method: HttpMethod.get,
      fromJson: (json) => UserModel.fromJson(json),
      onError: onError,
    );
  }

}






