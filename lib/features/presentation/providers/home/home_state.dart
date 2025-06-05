import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';

class HomeState {
  HomeState();

  List<Category> folders = [];
  List<Feed> feeds = [];
  List<Cluster> artiads = [];

  final stateFolderLen = 0.obs;
  final stateFeedLen = 0.obs;
  final stateArtiadLen = 0.obs;
  int get folderLen => stateFolderLen.value;
  int get feedLen => stateFeedLen.value;
  int get artiadLen => stateArtiadLen.value;

  final stateIsLoading = false.obs;
  bool get isLoading => stateIsLoading.value;
  set isLoading(bool b) => stateIsLoading.value = b;


}
