


import 'package:dartz/dartz.dart';
import 'package:follow_read/core/utils/failure.dart';
import 'package:follow_read/features/data/datasources/api_client.dart';
import 'package:follow_read/features/domain/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserService extends GetxService {

  final GetStorage storage = GetStorage();


  Future<Either<Failure, User>> login(String baseUrl, token) async {
    final userModel = await ApiClient.me(
      baseUrl: baseUrl,
      token: token,
    );
    return await userModel.fold((failure) async => Left(failure),
            (userModel) async {
          final user = userModel.to().copyWith(token: token, baseUrl: baseUrl);
          await storage.write("userId", user.id);
          await storage.write("token", token);
          return Right(user);
        });
  }

  User getCurrentUser() {
    int userId = storage.read("userId");
    return User(id: userId, username: "", isAdmin: true);
  }

  Future<void> logout() async {
    await storage.remove("userId");
    storage.listenKey('username', (value) {
      print('用户名更新为：$value');
    });
  }

}