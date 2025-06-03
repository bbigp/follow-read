import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:get/get.dart';

import 'aisthub_state.dart';

class AisthubController extends GetxController {
  final AisthubState state = AisthubState();

  Future<void> init() async {
    if (state.isLoading) return;
    state.isLoading = true;
    state.aists.assignAll(await aistRepository.getAll());
    state.isLoading = false;
  }
}
