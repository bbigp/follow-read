

import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../models/user.dart';

class LoginUseCase {

  LoginUseCase(); // 依赖注入

  Future<Either<Failure, User>>? execute(String baseUrl, String token) {
    return null;
  }

  Future<void> logout() async {
  }
}