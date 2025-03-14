
import 'package:follow_read/features/data/datasources/api_client.dart';
import 'package:follow_read/features/data/models/user_model.dart';

import '../datasources/auth_local_data_source.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> getCurrentUser();
}
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(
      this._localDataSource,
      );

  @override
  Future<UserModel> login(String email, String password) async {
    final userModel = await ApiClient.me();
    await _localDataSource.cacheUser(userModel!); // 可组合多个数据源
    return userModel; // 转换为领域层实体
  }

  Future<UserModel> getCurrentUser() async {
    final user =  await _localDataSource.getCachedUser();
    return user!;
  }

}