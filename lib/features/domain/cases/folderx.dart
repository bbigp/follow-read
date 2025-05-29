
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/providers/folders_provider.dart';


import 'base.dart';

class Folderx implements MetaDatax {

  @override
  final int id;
  const Folderx(this.id);

  @override
  AsyncValue<Category> get(WidgetRef ref){
    return ref.watch(uiProvider(id));
  }

  @override
  // TODO: implement _futureProvider
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider => throw UnimplementedError();

  @override
  AutoDisposeProviderFamily<AsyncValue<Category>, int> get uiProvider => AutoDisposeProviderFamily<AsyncValue<Category>, int>((ref, args) {
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