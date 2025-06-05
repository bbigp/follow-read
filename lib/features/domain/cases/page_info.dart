//
//
// import 'base.dart';
//
// class PageInfo<T> {
//   final List<T> list;
//   final int page;
//   final int size;
//   final SQLQueryBuilder? builder;
//   final bool hasMore;
//   final bool isLoadingMore;
//   const PageInfo({required this.list, this.page = 1, this.size = 10, this.builder,
//     this.hasMore = false, this.isLoadingMore = false,
//   });
//
//
//   PageInfo<T> copyWith({
//     List<T>? list,
//     int? page,
//     int? size,
//     SQLQueryBuilder? builder,
//     bool? hasMore,
//     bool? isLoadingMore,
//   }) {
//     return PageInfo<T>(
//       list: list ?? this.list,
//       page: page ?? this.page,
//       size: size ?? this.size,
//       builder: builder ?? this.builder,
//       hasMore: hasMore ?? this.hasMore,
//       isLoadingMore: isLoadingMore ?? this.isLoadingMore,
//     );
//   }
//
//
//   PageInfo<T> appendList(List<T> list, {
//     int? page,
//     int? size,
//     SQLQueryBuilder? builder,
//     bool? hasMore,
//   }) {
//     return PageInfo<T>(
//       list: [...this.list, ...list],
//       page: page ?? this.page,
//       size: size ?? this.size,
//       builder: builder ?? this.builder,
//       hasMore: hasMore ?? this.hasMore,
//       isLoadingMore: false,
//     );
//   }
// }