//
//
// // auth/domain/use_cases/get_current_user_use_case.dart
import 'package:follow_read/features/domain/entities/user_entity.dart';

import '../../data/repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UserEntity?> execute() async {
    return await _repository.getCurrentUser();
  }
}

