import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/providers/aists_provider.dart';
import 'package:follow_read/features/presentation/providers/entries_provider.dart';

import 'base.dart';


class Aistx extends MetaDatax {
  @override
  final int id;
  @override
  final bool search;
  Aistx(this.id, {this.search = false});

  @override
  String get type => Model.aist;

  @override
  AutoDisposeFutureProviderFamily<MetaViewData, int> get futureProvider =>
      AutoDisposeFutureProviderFamily<Cluster, int>((ref, args) async {
        final aists = await ref.watch(aistsProvider.future);
        return aists.firstWhere((c) => c.id == id, orElse: () => Cluster());
      });

  @override
  AutoDisposeProviderFamily<AsyncValue<Cluster>, int> get uiProvider =>
      AutoDisposeProviderFamily<AsyncValue<Cluster>, int>((ref, args) {
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

}
