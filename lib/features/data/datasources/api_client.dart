

import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../../../core/utils/follow_request.dart';
import '../models/user_model.dart';
import '../../../core/utils/http_utils.dart';

class ApiClient {
  static final httpUtil = HttpUtil();

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // 添加全局Header（如认证token）
  static void _setAuthorization(String token) {
    _headers['X-Auth-Token'] = token;
  }

  static Future<Either<Failure, UserModel>> me(
      {required String baseUrl,
      required String token,}) async {
    _setAuthorization(token);
    return await httpUtil.safeRequest<UserModel>(
      path: baseUrl + 'me',
      method: HttpMethod.get,
      fromJson: (json) => UserModelMapper.fromMap(json),
      headers: _headers,
    );
  }
}
