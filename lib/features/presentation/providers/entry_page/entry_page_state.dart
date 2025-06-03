import 'package:follow_read/features/domain/models/entry.dart';
import 'package:get/get.dart';

class EntryPageState {
  EntryPageState();

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

  final RxList<Entry> stateEntries = <Entry>[].obs;
  List<Entry> get entries => stateEntries;

  int page = 1;
  int size = 30;
  bool hasMore = false;
  bool isLoadingMore = false;


}
