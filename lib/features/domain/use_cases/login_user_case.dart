

import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../../data/repositories/user_repository.dart';
import '../models/user.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository); // 依赖注入

  Future<Either<Failure, User>> execute(String baseUrl, String token) {
    return repository.login(baseUrl, token);
  }

  Future<void> logout() async {
    await repository.logout();
  }
}