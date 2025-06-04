import 'package:follow_read/features/domain/models/entry.dart';
import 'package:get/get.dart';

class EntryhubState {
  EntryhubState();


  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

  List<Entry> entries = [];

  final stateHasMore = false.obs;
  bool get hasMore => stateHasMore.value;
  set hasMore(bool b) => stateHasMore.value = b;



  int page = 0;
  int size = 20;

  bool isLoadingMore = false;

  void addNextPage(List<Entry> nextPageList, {int? nextPage}){
    entries = [...entries, ...nextPageList];
    hasMore = nextPageList.length >= size;
    page = nextPage ?? page + 1;
  }
}
