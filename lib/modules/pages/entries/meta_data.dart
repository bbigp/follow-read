

import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/modules/controller/home/home_controller.dart';
import 'package:get/get.dart';

abstract class MetaViewData {
  String get title;
  int get unread;
  SQLQueryBuilder toBuilder();
}

abstract class MetaDatax {
  int get id;
  String get type;
  Future<MetaViewData> getMeta();
}


class ArtiadMeta extends MetaDatax {
  @override
  final int id;
  ArtiadMeta(this.id,);

  @override
  String get type => Model.artiad;

  @override
  Future<Cluster> getMeta() async {
    return await artiadRepository.getById(id);
  }

}


class FolderMeta extends MetaDatax {

  @override
  final int id;
  FolderMeta(this.id,);

  @override
  String get type => Model.folder;

  @override
  Future<Category> getMeta() async {
    final folder = await folderRepository.getCategoryById(id);
    final controller = Get.find<HomeController>();
    return folder.copyWith(feeds: controller.state.feedMap[folder.id] ?? []);
  }

}

class FeedMeta extends MetaDatax {

  @override
  final int id;
  FeedMeta(this.id,);

  @override
  String get type => Model.feed;

  @override
  Future<Feed> getMeta() async {
    return await feedRepository.getFeedById(id);
  }

}


class SQLQueryBuilder {
  final List<int> feedIds;
  final List<String> statuses;
  final DateTime? minPublishedTime;
  final DateTime? minAddTime;
  final bool? starred;
  final String order;
  final String word;

  const SQLQueryBuilder({
    this.feedIds = const [],
    this.statuses = const [],
    this.minPublishedTime,
    this.minAddTime,
    this.starred,
    this.order = Model.orderxPublishedAt,
    this.word = "",
  });


  SQLQueryBuilder copyWith({
    List<int>? feedIds,
    List<String>? statuses,
    DateTime? minPublishedTime,
    DateTime? minAddTime,
    bool? starred,
    String? order,
    String? word,
  }) {
    return SQLQueryBuilder(
      feedIds: feedIds ?? this.feedIds,
      statuses: statuses ?? this.statuses,
      minPublishedTime: minPublishedTime ?? this.minPublishedTime,
      minAddTime: minAddTime ?? this.minAddTime,
      starred: starred ?? this.starred,
      order: order ?? this.order,
      word: word ?? this.word,
    );
  }

  @override
  String toString() {
    return 'SQLQueryBuilder('
        'feedIds: $feedIds, '
        'statuses: $statuses, '
        'minPublishedTime: $minPublishedTime, '
        'minAddTime: $minAddTime, '
        'starred: $starred, '
        'order: $order, '
        'word: $word'
        ')';
  }

}