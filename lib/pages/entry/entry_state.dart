import 'package:follow_read/features/domain/models/entry.dart';
import 'package:get/get.dart';

class EntryState {
  EntryState();

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;

  final stateEntry = Entry.empty.obs;
  Entry get entry => stateEntry.value;
  set entry(Entry e) => stateEntry.value = e;


}
