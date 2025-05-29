import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/page_info.dart';



abstract class MetaViewData {
  String get title;
  int get unread;
  SQLQueryBuilder toBuilder();
}

abstract class MetaDatax {
  int get id;
  AsyncValue<MetaViewData> get(WidgetRef ref);
  AutoDisposeProviderFamily<AsyncValue<MetaViewData>, int> get uiProvider;
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider;
  AsyncValue<PageInfo<Entry>> page(WidgetRef ref);
  void loadMore(WidgetRef ref);
  Future<SQLQueryBuilder> sqlBuilder(Ref ref);
  void refresh(WidgetRef ref);
}


class SQLQueryBuilder {
  final List<int> feedIds;
  final List<String> statuses;
  final DateTime? minPublishedTime;
  final DateTime? minAddTime;
  final bool starred;
  final int page;
  final int pageSize;
  final String? order;

  const SQLQueryBuilder({
    this.feedIds = const [],
    this.statuses = const [],
    this.minPublishedTime,
    this.minAddTime,
    this.starred = false,
    required this.page,
    required this.pageSize,
    this.order,
  });
}