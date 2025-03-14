

import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../models/user_model.dart';
import '../../../core/utils/http_utils.dart';


class ApiClient {

  static final httpUtil = HttpUtil();


  static Future<Either<Failure, UserModel>> me({required String token, Function(ApiException)? onError}) async {
    if (token == "") {
      token = 'lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600=';
    }
    httpUtil.setAuthorization(token);
    return await httpUtil.safeRequest<UserModel>(
      path: 'me',
      method: HttpMethod.get,
      fromJson: (json) => UserModel.fromJson(json),
    );
  }

}






