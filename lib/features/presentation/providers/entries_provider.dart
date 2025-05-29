

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/cases/base.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';

import 'app_container.dart';

final entriesProvider = AsyncNotifierProvider.autoDispose.family<EntriesNotifier, PageInfo<Entry>, MetaDatax>(
  EntriesNotifier.new,
);

class EntriesNotifier extends AutoDisposeFamilyAsyncNotifier<PageInfo<Entry>, MetaDatax> {

  late final _entryRepository = ref.watch(entryRepositoryProvider);

  @override
  FutureOr<PageInfo<Entry>> build(arg) async {
    await Future.delayed(Duration(seconds: 1));
    final size = 10;
    final builder = await arg.sqlBuilder(ref);
    final entries = await _entryRepository.fetchEntries(1, size, builder);
    return PageInfo(list: entries, builder: builder, hasMore: entries.length >= size);
  }

  void nextPage() async {
    final pageInfo = state.requireValue;
    if (pageInfo.isLoadingMore) return;
    state = AsyncData(pageInfo.copyWith(isLoadingMore: true));
    final nextPage = pageInfo.page + 1;
    final entries = await _entryRepository.fetchEntries(nextPage, pageInfo.size, pageInfo.builder!);
    state = AsyncData(pageInfo.appendList(entries, page: nextPage,
        hasMore: entries.length >= pageInfo.size
    ));
  }

}