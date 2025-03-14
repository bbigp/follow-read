import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/datasources/local_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/user_repository.dart';
import '../../domain/use_cases/get_current_user_use_case.dart';
import '../../domain/use_cases/login_user_case.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // 在 main 中被 override
});

final localDataSourceProvider = Provider<LocalData>((ref) {
  return LocalData(ref.watch(sharedPreferencesProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    ref.watch(localDataSourceProvider),
  );
});
//
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(userRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.watch(userRepositoryProvider));
});