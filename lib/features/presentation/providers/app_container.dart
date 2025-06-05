import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/datasources/cluster_dao.dart';
import 'package:follow_read/features/data/datasources/conf_dao.dart';
import 'package:follow_read/features/data/datasources/entry_dao.dart';
import 'package:follow_read/features/data/datasources/local_data.dart';
import 'package:follow_read/features/data/datasources/search_dao.dart';
import 'package:follow_read/features/data/repositories/cluster_repository.dart';
import 'package:follow_read/features/data/repositories/entry_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/category_dao.dart';
import '../../data/datasources/database.dart';
import '../../data/datasources/feed_dao.dart';
import '../../data/repositories/category_repository.dart';
import '../../data/repositories/feed_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/use_cases/get_current_user_use_case.dart';
import '../../domain/use_cases/login_user_case.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // 在 main 中被 override
});

final localData = LocalData();
final localDataSourceProvider = Provider<LocalData>((ref) {
  return localData;
});

final database = AppDatabase();
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return database;
});





//
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(userRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.watch(userRepositoryProvider));
});






final feedDao = FeedDao(database);
final feedDaoProvider = Provider<FeedDao>((ref) {
  return feedDao;
});
final entryDao = EntryDao(database);
final entryDaoProvider = Provider<EntryDao>((ref) {
  return entryDao;
});
final categoryDao = CategoryDao(database);
final categoryDaoProvider = Provider<CategoryDao>((ref){
  return categoryDao;
});
final confDaoProvider = Provider<ConfDao>((ref){
  return ConfDao(ref.watch(appDatabaseProvider));
});
final searchDaoProvider = Provider<SearchDao>((ref){
  return SearchDao(ref.watch(appDatabaseProvider));
});
final aistDao = ClusterDao(database);
final clusterDaoProvider = Provider((ref){
  return aistDao;
});

final feedRepository = FeedRepository(
    feedDao: feedDao,
    localData: localData,
    categoryDao: categoryDao, entryDao: entryDao
);
final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return feedRepository;
});
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(localDataSourceProvider),);
});
final entryRepository = EntryRepository(
    dao: entryDao, feedDao: feedDao,
    feedRepository: feedRepository,
    clusterDao: aistDao
);
final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return entryRepository;
});
final folderRepository = CategoryRepository(
  dao: categoryDao,
);
final categoryRepositoryProvider = Provider<CategoryRepository>((ref){
  return folderRepository;
});
final artiadRepository = ClusterRepository(dao: aistDao);
final clusterRepositoryProvider = Provider((ref){
  return artiadRepository;
});