

import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../../data/repositories/user_repository.dart';
import '../entities/user_entry.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository); // 依赖注入

  Future<Either<Failure, UserEntity>> execute(String token) {
    return repository.login(token);
  }
}