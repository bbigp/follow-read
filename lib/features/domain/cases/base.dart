import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/entries_provider.dart';



abstract class MetaViewData {
  String get title;
  int get unread;
  SQLQueryBuilder toBuilder();
}

abstract class MetaDatax {
  int get id;
  AutoDisposeProviderFamily<AsyncValue<MetaViewData>, int> get uiProvider;
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider;
  String get type;
  bool get search;

  @override
  bool operator ==(Object other) =>
      other is MetaDatax && (other.hashCode)  == hashCode;

  @override
  int get hashCode => type.hashCode + search.hashCode + id;

  AsyncValue<MetaViewData> get(WidgetRef ref) {
    return ref.watch(uiProvider(id));
  }
  AsyncValue<PageInfo<Entry>> page(WidgetRef ref) {
    return ref.watch(entriesProvider(this));
  }
  void loadMore(WidgetRef ref, {String word = ""}) {
    ref.read(entriesProvider(this).notifier).nextPage(word: word);
  }
  void init(WidgetRef ref) {
    ref.refresh(entriesProvider(this));
  }
  Future<SQLQueryBuilder> sqlBuilder(Ref ref) async {
    final meta = await ref.watch(futureProvider(id).future);
    return meta.toBuilder();
  }
  void refresh(WidgetRef ref) async {
    final _ = ref.refresh(uiProvider(id));
    final state = await ref.refresh(entriesProvider(this).future);
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