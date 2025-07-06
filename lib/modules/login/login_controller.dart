

import 'package:follow_read/data/services/user_service.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final state = LoginState();
  final userService = Get.find<UserService>();

  void change({String? apiURL, String? apiToken}){
    if (apiURL != null) {
      state.stateApiURL.value = apiURL;
    }
    if (apiToken != null) {
      state.stateApiToken.value = apiToken;
    }
  }

  Future<void> login() async {
    var url = state.apiURL;
    if (url.isEmpty) {
      return;
    }
    if (state.apiToken.isEmpty) return;
    if (!url.endsWith("v1") && !url.endsWith("v1/")) {
      url = "${url}v1/";
    }
    final success = await userService.login(url, state.apiToken, onError: (v) {
      Get.snackbar("错误", v, snackPosition:  SnackPosition.TOP);
    });
    if (!success) {
      return;
    }
    Get.offAllNamed(RouteConfig.main);
  }

}

class LoginState {
  final stateApiURL = "https://feedo.coolbet.cn/".obs;
  String get apiURL => stateApiURL.value;

  final stateApiToken = "lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600=".obs;
  String get apiToken => stateApiToken.value;
}

class LoginBinding extends Bindings {

  @override
  void dependencies() {
      Get.lazyPut(() => LoginController());
  }
}