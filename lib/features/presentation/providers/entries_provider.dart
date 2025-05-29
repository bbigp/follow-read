

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/feedx.dart';
import 'package:follow_read/features/domain/models/page_info.dart';

import 'app_container.dart';

final entriesProvider = AsyncNotifierProvider.autoDispose.family<EntriesNotifier, PageInfo<Entry>, MetaDatax>(
  EntriesNotifier.new,
);

class EntriesNotifier extends AutoDisposeFamilyAsyncNotifier<PageInfo<Entry>, MetaDatax> {

  late final _entryRepository = ref.watch(entryRepositoryProvider);

  @override
  FutureOr<PageInfo<Entry>> build(arg) async {
    final builder = await arg.sqlBuilder(ref);
    final entries = await _entryRepository.fetchEntries(1, 10, builder);
    return PageInfo(list: entries, builder: builder);
  }

  void nextPage() async {
    final pageInfo = state.requireValue;
    final nextPage = pageInfo.page + 1;
    final entries = await _entryRepository.fetchEntries(nextPage, pageInfo.size, pageInfo.builder!);
    state = AsyncData(pageInfo.appendList(entries, page: nextPage));
  }

}