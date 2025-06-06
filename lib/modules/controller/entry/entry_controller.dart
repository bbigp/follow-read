import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:get/get.dart';

import 'entry_state.dart';



class EntryController extends GetxController {
  final EntryState state = EntryState();

  final int entryId;
  EntryController(this.entryId);


  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    if (state.isLoading) return;
    state.isLoading = true;
    state.entry = await entryRepository.getEntry(entryId);
    state.isLoading = false;
  }


  Future<void> starred() async {
    final entry = state.entry;
    final success = await entryRepository.starred(entryId, !entry.starred);
    if (success) {
      entry.copyWith(starred: !entry.starred);
      return;
    }
  }


  Future<void> read({String status = ""}) async {
    final entry = state.entry;
    final s = status.isNotEmpty ? status : entry.status == Model.read ? Model.unread : Model.read;
    if (entry.status == s) return;
    final success = await entryRepository.updateStatus(entryId, s);
    if (success) {
      entry.copyWith(status: s);
    }
  }

}
