import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/page_info.dart';
import 'package:follow_read/features/presentation/providers/aists_provider.dart';

import 'base.dart';


class Aistx implements MetaDatax {
  @override
  final int id;
  const Aistx(this.id);

  @override
  AsyncValue<Cluster> get(WidgetRef ref){
    return ref.watch(uiProvider(id));
  }

  @override
  // TODO: implement _futureProvider
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider => throw UnimplementedError();

  @override
  AutoDisposeProviderFamily<AsyncValue<Cluster>, int> get uiProvider => AutoDisposeProviderFamily<AsyncValue<Cluster>, int>((ref, args) {
    final aists = ref.watch(aistsProvider);
    return aists.when(
        data: (list) {
          final item = list.firstWhere((c) => c.id == id, orElse: () => Cluster());
          return AsyncData(item);
        },
        error: (error, stackTrace) => AsyncError(error, stackTrace),
        loading: () => AsyncLoading()
    );
  });



  @override
  Future<SQLQueryBuilder> sqlBuilder(Ref ref) {
    // TODO: implement sqlBuilder
    throw UnimplementedError();
  }

  @override
  AsyncValue<PageInfo<Entry>> page(WidgetRef ref) {
    // TODO: implement page
    throw UnimplementedError();
  }

  @override
  void loadMore(WidgetRef ref) {
    // TODO: implement loadMore
  }
  @override
  void refresh(WidgetRef ref) {
    // TODO: implement refresh
  }
}
