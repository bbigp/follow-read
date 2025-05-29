

import 'package:follow_read/features/domain/models/feed.dart';

class PageInfo<T> {
  final List<T> list;
  final int page;
  final int size;
  final SQLQueryBuilder? builder;
  const PageInfo({required this.list, this.page = 1, this.size = 10, this.builder});

  PageInfo<T> appendList(List<T> list, {
    int? page,
    int? size,
    SQLQueryBuilder? builder,
  }) {
    return PageInfo<T>(
      list: [...this.list, ...list],
      page: page ?? this.page,
      size: size ?? this.size,
      builder: builder ?? this.builder,
    );
  }
}