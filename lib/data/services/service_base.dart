

import 'package:follow_read/data/repositories/app_database.dart';
import 'package:follow_read/di.dart';
import 'package:get/get.dart';

abstract class ServiceBase extends GetxService {

  late final AppDatabase db;

  @override
  void onInit() {
    super.onInit();
    db = Get.find<DBService>().db;
  }

}