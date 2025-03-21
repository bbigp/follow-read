import 'package:dartz/dartz.dart';
import 'package:follow_read/features/data/datasources/api_client.dart';
import 'package:follow_read/features/domain/models/user.dart';

import '../../../core/utils/failure.dart';
import '../datasources/local_data.dart';

class UserRepository {
  final LocalData _localDataSource;

  UserRepository(
    this._localDataSource,
  );

  Future<Either<Failure, User>> login(String baseUrl, token) async {
    final userModel = await ApiClient.me(
      baseUrl: baseUrl,
      token: token,
    );
    return await userModel.fold((failure) async => Left(failure),
        (userModel) async {
      final user = userModel.to().copyWith(token: token, baseUrl: baseUrl);
      await _localDataSource.cacheUser(user);
      return Right(user);
    });
  }

  Future<User?> getCurrentUser() async {
    return await _localDataSource.getCachedUser();
  }

  Future<void> logout() async {
    await _localDataSource.deleteUser();
  }
}
