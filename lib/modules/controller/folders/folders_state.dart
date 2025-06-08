import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class FoldersState {
  FoldersState();

  RxList<Category> folders = <Category>[].obs;

  final stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

}
