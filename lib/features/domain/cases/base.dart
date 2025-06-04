import 'dart:async';

import 'package:follow_read/features/domain/models/constants.dart';



abstract class MetaViewData {
  String get title;
  int get unread;
  SQLQueryBuilder toBuilder();
}

abstract class MetaDatax {
  int get id;
  String get type;
  bool get search;

  MetaViewData getMeta();

  @override
  bool operator ==(Object other) =>
      other is MetaDatax && (other.hashCode)  == hashCode;

  @override
  int get hashCode => type.hashCode + search.hashCode + id;

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