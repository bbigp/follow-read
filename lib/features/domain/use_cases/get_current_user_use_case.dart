//
//
// // auth/domain/use_cases/get_current_user_use_case.dart
import 'package:follow_read/features/data/models/user_model.dart';

import '../../data/repositories/auth_repository_impl.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UserModel?> execute() async {
    return await _repository.getCurrentUser();
  }
}

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository); // 依赖注入

  Future<UserModel> execute(String email, String password) {
    return repository.login(email, password);
  }
}