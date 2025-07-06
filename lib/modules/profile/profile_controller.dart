

import 'package:flutter/material.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final state = ProfileState();

  final userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    state._stateUser.value = userService.getUser();
  }

  void change({bool? autoRead, String? unreadMark, String? openContent}) async {
    await userService.save(autoRead: autoRead, unreadMark: unreadMark,
      openContent: openContent
    );
    onInit();
  }

}

class ProfileState {

  final _stateUser = User.empty.obs;
  User get user => _stateUser.value;

}