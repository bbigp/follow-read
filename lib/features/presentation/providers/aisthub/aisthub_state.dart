import 'package:follow_read/features/domain/models/aist.dart';
import 'package:get/get.dart';

class AisthubState {
  AisthubState();

  final RxBool stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;


  final RxList<Cluster> stateAists = <Cluster>[].obs;
  List<Cluster> get aists => stateAists;

}
