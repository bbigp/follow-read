import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class FolderhubState {
  FolderhubState();

  List<Category> folders = [];
  Category rootFolder = Category.empty;

  final len = 0.obs;

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

}
