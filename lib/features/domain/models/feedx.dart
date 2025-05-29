

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/page_info.dart';
import 'package:follow_read/features/presentation/providers/aists_provider.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/entries_provider.dart';
import 'package:follow_read/features/presentation/providers/feeds_provider.dart';
import 'package:follow_read/features/presentation/providers/folders_provider.dart';

abstract class MetaViewData {
  String get title;
  int get unread;
  SQLQueryBuilder toBuilder();
}

abstract class MetaDatax {
  int get id;
  AsyncValue<MetaViewData> get(WidgetRef ref);
  AutoDisposeProviderFamily<AsyncValue<MetaViewData>, int> get _uiProvider;
  AutoDisposeFutureProviderFamily<MetaViewData, int> get _futureProvider;
  AsyncValue<PageInfo<Entry>> page(WidgetRef ref, int page);
  Future<SQLQueryBuilder> sqlBuilder(Ref ref);
}


class Feedx implements MetaDatax {
  
  @override
  final int id;
  const Feedx(this.id);

  @override
  AsyncValue<Feed> get(WidgetRef ref){
    return ref.watch(_uiProvider(id));
  }

  @override
  Future<SQLQueryBuilder> sqlBuilder(Ref ref) async {
    final feed = await ref.watch(_futureProvider(id).future);
    return feed.toBuilder();
  }

  @override
  AutoDisposeProviderFamily<AsyncValue<Feed>, int> get _uiProvider =>
      AutoDisposeProviderFamily<AsyncValue<Feed>, int>((ref, args) {
        final feeds = ref.watch(feedsProvider);
        return feeds.when(
            data: (list) {
              final item = list.firstWhere((c) => c.id == id, orElse: () => Feed.empty);
              return AsyncData(item);
            },
            error: (error, stackTrace) => AsyncError(error, stackTrace),
            loading: () => AsyncLoading()
        );
      });

  @override
  AutoDisposeFutureProviderFamily<MetaViewData, int> get _futureProvider =>
      AutoDisposeFutureProviderFamily<Feed, int>((ref, args) async {
        final feeds = await ref.watch(feedsProvider.future);
        return feeds.firstWhere((c) => c.id == id, orElse: () => Feed.empty);
      });

  @override
  AsyncValue<PageInfo<Entry>> page(WidgetRef ref, int page) {
    if (page == 1)
    return ref.watch(entriesProvider(this));
  }
}


class Folderx implements MetaDatax {

  final int id;
  const Folderx(this.id);

  @override
  AsyncValue<Category> get(WidgetRef ref){
    return ref.watch(_uiProvider(id));
  }

  @override
  // TODO: implement _futureProvider
  AutoDisposeFutureProviderFamily<MetaViewData, int> get _futureProvider => throw UnimplementedError();

  @override
  AutoDisposeProviderFamily<AsyncValue<Category>, int> get _uiProvider => AutoDisposeProviderFamily<AsyncValue<Category>, int>((ref, args) {
    final folders = ref.watch(foldersProvider);
    return folders.when(
        data: (list) {
          final item = list.firstWhere((c) => c.id == id, orElse: () => Category.empty);
          return AsyncData(item);
        },
        error: (error, stackTrace) => AsyncError(error, stackTrace),
        loading: () => AsyncLoading()
    );
  });

  @override
  PageInfo<Entry> page(WidgetRef ref) {
    // TODO: implement page
    throw UnimplementedError();
  }

  @override
  Future<SQLQueryBuilder> sqlBuilder(Ref ref) {
    // TODO: implement sqlBuilder
    throw UnimplementedError();
  }

}

class Aistx implements MetaDatax {
  final int id;
  const Aistx(this.id);

  @override
  AsyncValue<Cluster> get(WidgetRef ref){
    return ref.watch(_uiProvider(id));
  }

  @override
  // TODO: implement _futureProvider
  AutoDisposeFutureProviderFamily<MetaViewData, int> get _futureProvider => throw UnimplementedError();

  @override
  AutoDisposeProviderFamily<AsyncValue<Cluster>, int> get _uiProvider => AutoDisposeProviderFamily<AsyncValue<Cluster>, int>((ref, args) {
    final aists = ref.watch(aistsProvider);
    return aists.when(
        data: (list) {
          final item = list.firstWhere((c) => c.id == id, orElse: () => Cluster.empty);
          return AsyncData(item);
        },
        error: (error, stackTrace) => AsyncError(error, stackTrace),
        loading: () => AsyncLoading()
    );
  });

  @override
  PageInfo<Entry> page(WidgetRef ref) {
    // TODO: implement page
    throw UnimplementedError();
  }

  @override
  Future<SQLQueryBuilder> sqlBuilder(Ref ref) {
    // TODO: implement sqlBuilder
    throw UnimplementedError();
  }
}
