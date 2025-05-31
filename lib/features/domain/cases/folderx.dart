
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/providers/entries_provider.dart';
import 'package:follow_read/features/presentation/providers/folders_provider.dart';


import 'base.dart';

class Folderx extends MetaDatax {

  @override
  final int id;
  @override
  final bool search;
  Folderx(this.id, {this.search = false});

  @override
  String get type => Model.folder;

  @override
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider =>
      AutoDisposeFutureProviderFamily<Category, int>((ref, args) async {
        final folders = await ref.watch(foldersProvider.future);
        return folders.firstWhere((c) => c.id == id, orElse: () => Category.empty);
      });

  @override
  AutoDisposeProviderFamily<AsyncValue<Category>, int> get uiProvider =>
      AutoDisposeProviderFamily<AsyncValue<Category>, int>((ref, args) {
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

}