import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/datasources/entry_dao.dart';
import 'package:follow_read/features/data/datasources/local_data.dart';
import 'package:follow_read/features/data/repositories/entry_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/database.dart';
import '../../data/datasources/feed_dao.dart';
import '../../data/repositories/feed_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/use_cases/get_current_user_use_case.dart';
import '../../domain/use_cases/login_user_case.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // 在 main 中被 override
});

final localDataSourceProvider = Provider<LocalData>((ref) {
  return LocalData(ref.watch(sharedPreferencesProvider));
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});





//
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(userRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.watch(userRepositoryProvider));
});







final feedDaoProvider = Provider<FeedDao>((ref) {
  return FeedDao(ref.watch(appDatabaseProvider));
});
final entryDaoProvider = Provider<EntryDao>((ref) {
  return EntryDao(ref.watch(appDatabaseProvider));
});




final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepository(
      feedDao: ref.watch(feedDaoProvider),
      localData: ref.watch(localDataSourceProvider),
  );
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(localDataSourceProvider),);
});

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return EntryRepository(
      dao: ref.watch(entryDaoProvider),
      feedDao: ref.watch(feedDaoProvider),
      sharedPreferences: ref.watch(sharedPreferencesProvider),
    feedRepository: ref.watch(feedRepositoryProvider),
  );
});