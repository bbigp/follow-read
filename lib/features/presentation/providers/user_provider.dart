//
//
//
//
// import 'dart:async';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:follow_read/features/data/datasources/conf_dao.dart';
// import 'package:follow_read/features/domain/models/conf.dart';
// import 'package:follow_read/features/domain/models/user.dart';
// import 'package:follow_read/features/presentation/providers/app_container.dart';
//
// import '../../data/datasources/local_data.dart';
//
//
// final showAllProvider = Provider.autoDispose<bool>((ref) {
//   final asyncUser = ref.watch(userProvider);
//   return asyncUser.when(
//     data: (user) => user.showAll,
//     loading: () => false,
//     error: (_, __) => false,
//   );
// });
//
//
// final userProvider = AsyncNotifierProvider.autoDispose<UserNotifier, OneUser>(
//     UserNotifier.new
// );
//
//
// class UserNotifier extends AutoDisposeAsyncNotifier<OneUser> {
//
//   late final ConfDao confDao;
//   late final LocalData localData;
//
//
//   @override
//   FutureOr<OneUser> build() async {
//     confDao = ref.watch(confDaoProvider);
//     localData = ref.watch(localDataSourceProvider);
//     User user = await localData.getCachedUser() ?? User.empty;
//     final cfs = await confDao.getByUserId(user.id);
//
//     bool? showAll;
//     bool? autoRead;
//     List<String>? urls;
//     for (var conf in cfs) {
//       if (conf.name == Conf.keyShowAll) {
//         showAll = bool.parse(conf.value);
//       }
//       if (conf.name == Conf.keyAutoRead) {
//         autoRead = bool.parse(conf.value);
//       }
//       if (conf.name == Conf.keyBaseUrls) {
//         urls = conf.value.split(",");
//       }
//     }
//     return OneUser(user: user).copyWith(showAll: showAll, autoRead: autoRead,
//       urls: urls);
//   }
//
//   Future<void> saveConf({bool? autoRead, bool? showAll}) async {
//     final userId = state.value?.user.id;
//     await confDao.saveConf(userId!, autoRead: autoRead, showAll: showAll);
//     state = AsyncData(state.value!.copyWith(
//       autoRead: autoRead, showAll: showAll,
//     ));
//   }
//
//   Future<bool> saveUrl(String url) async {
//     final userId = state.value?.user.id;
//     final newValues = [...state.value!.urls, url];
//     await confDao.saveConf(userId!, baseUrls: newValues);
//     state = AsyncData(state.value!.copyWith(
//       urls: newValues,
//     ));
//     return true;
//   }
//
//   Future<void> chooseUrl(String url) async {
//     if (!state.value!.urls.contains(url)) {
//       return;
//     }
//     final newUser = state.value!.user.copyWith(baseUrl: url);
//     await localData.cacheUser(newUser);
//     state = AsyncData(state.value!.copyWith(user: newUser));
//   }
// }
//
// class OneUser {
//
//   final User user;
//   final bool showAll;
//   final bool autoRead;
//   final List<String> urls;
//
//   OneUser({
//     this.user = const User(id: 0, username: "", isAdmin: false),
//     this.showAll = false,
//     this.autoRead = false,
//     this.urls = const [],
//   });
//
//
//   OneUser copyWith({
//     User? user,
//     bool? showAll,
//     bool? autoRead,
//     List<String>? urls,
//   }) {
//     return OneUser(
//       user: user ?? this.user,
//       showAll: showAll ?? this.showAll,
//       autoRead: autoRead ?? this.autoRead,
//         urls: urls ?? this.urls,
//     );
//   }
// }