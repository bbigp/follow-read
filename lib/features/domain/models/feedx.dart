

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/page_info.dart';
import 'package:follow_read/features/presentation/providers/entries_provider.dart';
import 'package:follow_read/features/presentation/providers/feeds_provider.dart';

import 'base.dart';

class Feedx implements MetaDatax {
  
  @override
  final int id;
  const Feedx(this.id);

  @override
  AsyncValue<Feed> get(WidgetRef ref){
    return ref.watch(uiProvider(id));
  }

  @override
  Future<SQLQueryBuilder> sqlBuilder(Ref ref) async {
    final feed = await ref.watch(futureProvider(id).future);
    return feed.toBuilder();
  }

  @override
  void refresh(WidgetRef ref) async {
    final _ = ref.refresh(uiProvider(id));
    final state = await ref.refresh(entriesProvider(this).future);
  }

  @override
  AutoDisposeProviderFamily<AsyncValue<Feed>, int> get uiProvider =>
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
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider =>
      AutoDisposeFutureProviderFamily<Feed, int>((ref, args) async {
        final feeds = await ref.watch(feedsProvider.future);
        return feeds.firstWhere((c) => c.id == id, orElse: () => Feed.empty);
      });

  @override
  AsyncValue<PageInfo<Entry>> page(WidgetRef ref) {
    return ref.watch(entriesProvider(this));
  }

  @override
  void loadMore(WidgetRef ref) {
      ref.read(entriesProvider(this).notifier).nextPage();
  }
}



