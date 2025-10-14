


import 'package:follow_read/data/model/page_state.dart';
import 'package:follow_read/data/model/pending_change.dart';
import 'package:follow_read/data/repositories/pending_change_dao.dart';
import 'package:follow_read/di.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class PendingChangeController extends PagedController<PendingChange> {

  @override
  final state = PendingChangeState();
  final pendingChangeDao = PendingChangeDao(Get.find<DBService>().db);
  final profile = Get.find<ProfileController>();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  @override
  Future<List<PendingChange>> fetchData(int page, int size) async {
      return await pendingChangeDao.getPage(profile.state.user.id, page: page, size: size);
  }

  Future<void> submit(PendingChange item) async {

  }

}


class PendingChangeState extends PageState<PendingChange>{

}