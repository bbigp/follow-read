//
//
// // auth/domain/use_cases/get_current_user_use_case.dart
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UserEntity?> execute() async {
    return await _repository.getCurrentUser();
  }
}