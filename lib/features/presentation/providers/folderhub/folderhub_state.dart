import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class FolderhubState {
  FolderhubState();

  final RxList<Category> stateFolders = <Category>[].obs;
  List<Category> get folders => stateFolders;

  // final Rx<Category> stateRootFolder = Category.empty.obs;
  // Category get rootFolder => stateRootFolder.value;
  Category rootFolder = Category.empty;

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

}
