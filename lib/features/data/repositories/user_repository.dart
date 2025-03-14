
import 'package:dartz/dartz.dart';
import 'package:follow_read/features/data/datasources/api_client.dart';
import 'package:follow_read/features/domain/entities/user_entry.dart';

import '../../../core/utils/failure.dart';
import '../datasources/local_data.dart';

class UserRepository {
  final LocalData _localDataSource;

  UserRepository(this._localDataSource,);

  Future<Either<Failure, UserEntity>> login(token) async {
    final userModel = await ApiClient.me(token: token,);
    return await userModel.fold(
            (failure) async => Left(failure),
            (userModel) async {
          userModel.token = token;
          await _localDataSource.cacheUser(userModel);
          return Right(userModel.toEntity());
        }
    );
  }

  Future<UserEntity> getCurrentUser() async {
    final user = await _localDataSource.getCachedUser();
    return user!.toEntity();
  }

}