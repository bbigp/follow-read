

import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(ProfileController());
  }

}