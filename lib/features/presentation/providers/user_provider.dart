



import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/datasources/conf_dao.dart';
import 'package:follow_read/features/data/datasources/entities/conf_entity.dart';
import 'package:follow_read/features/domain/models/conf.dart';
import 'package:follow_read/features/domain/models/user.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../data/datasources/local_data.dart';

final userProvider = AsyncNotifierProvider.autoDispose<UserNotifier, OneUser>(
    UserNotifier.new
);


class UserNotifier extends AutoDisposeAsyncNotifier<OneUser> {

  late final ConfDao confDao;
  late final LocalData localData;


  @override
  FutureOr<OneUser> build() async {
    confDao = ref.watch(confDaoProvider);
    localData = ref.watch(localDataSourceProvider);
    User user = await localData.getCachedUser() ?? User.empty;
    final cfs = await confDao.getByUserId(user.id);

    bool showHide = false;
    bool autoRead = false;
    for (var conf in cfs) {
      if (conf.name == "showHide") {
        showHide = bool.parse(conf.value);
      }
      if (conf.name == "autoRead") {
        autoRead = bool.parse(conf.value);
      }
    }
    return OneUser(user: user).copyWith(showHide: showHide, autoRead: autoRead);
  }

  Future<void> saveConf({bool? autoRead, bool? showHide}) async {
    final userId = state.value?.user.id;
    await confDao.saveConf(userId!, autoRead: autoRead, showHide: showHide);
    state = AsyncData(state.value!.copyWith(
      autoRead: autoRead, showHide: showHide,
    ));
  }

}

class OneUser {

  final User user;
  final bool showHide;
  final bool autoRead;

  OneUser({
    this.user = const User(id: 0, username: "", isAdmin: false),
    this.showHide = false,
    this.autoRead = false,
  });


  OneUser copyWith({
    User? user,
    bool? showHide,
    bool? autoRead,
  }) {
    return OneUser(
      user: user ?? this.user,
      showHide: showHide ?? this.showHide,
      autoRead: autoRead ?? this.autoRead,
    );
  }
}