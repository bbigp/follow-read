

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/providers/entries_provider.dart';
import 'package:follow_read/features/presentation/providers/feeds_provider.dart';

import 'base.dart';

class Feedx extends MetaDatax {
  
  @override
  final int id;
  @override
  final bool search;
  Feedx(this.id, {this.search = false});

  @override
  String get type => Model.feed;

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


}



