import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:get/get.dart';

import 'meta_data.dart';

class EntriesState {
  EntriesState();


  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

  List<Entry> entries = [];

  final stateHasMore = false.obs;
  bool get hasMore => stateHasMore.value;
  set hasMore(bool b) => stateHasMore.value = b;

  final stateLen = 0.obs;
  int get len => stateLen.value;


  int page = 0;
  int size = 20;

  bool isLoadingMore = false;

  MetaViewData meta = Feed.empty;

  void addNextPage(List<Entry> nextPageList, {int? nextPage}){
    entries = [...entries, ...nextPageList];
    hasMore = nextPageList.length >= size;
    page = nextPage ?? page + 1;
    stateLen.value = entries.length;
  }
}
