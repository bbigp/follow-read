import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class FolderhubState {
  FolderhubState();

  List<Category> folders = [];
  Category rootFolder = Category.empty;

  final stateLen = 0.obs;
  int get len => stateLen.value;
  set len(int length) => stateLen.value = length;

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

}
