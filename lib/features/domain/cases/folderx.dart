
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/providers/entries_provider.dart';
import 'package:follow_read/features/presentation/providers/folders_provider.dart';


import 'base.dart';

class Folderx extends MetaDatax {

  @override
  final int id;
  Folderx(this.id);

  @override
  AsyncValue<Category> get(WidgetRef ref){
    return ref.watch(uiProvider(id));
  }

  @override
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider =>
      AutoDisposeFutureProviderFamily<Category, int>((ref, args) async {
        final folders = await ref.watch(foldersProvider.future);
        return folders.firstWhere((c) => c.id == id, orElse: () => Category.empty);
      });

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
  void refresh(WidgetRef ref) {
    // TODO: implement refresh
  }


}