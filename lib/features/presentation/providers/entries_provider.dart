

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/domain/cases/base.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';

import 'app_container.dart';

final entriesProvider = AsyncNotifierProvider.autoDispose.family<EntriesNotifier, PageInfo<Entry>, MetaDatax>(
  EntriesNotifier.new,
);

class EntriesNotifier extends AutoDisposeFamilyAsyncNotifier<PageInfo<Entry>, MetaDatax> {

  late final _entryRepository = ref.watch(entryRepositoryProvider);
  late final _searchDao = ref.watch(searchDaoProvider);
  @override
  FutureOr<PageInfo<Entry>> build(arg) async {
    logger.i("初始化entries");
    ref.onDispose((){
      logger.i("释放entries.....");
    });
    final builder = await arg.sqlBuilder(ref);
    final size = 20;
    final page = 1;
    if (arg.search) {
      return PageInfo(builder: builder, list: [], page: 0, size: size);
    }
    await Future.delayed(Duration(milliseconds: 500));
    final entries = await _entryRepository.fetchEntries(page, size, builder);
    return PageInfo(builder: builder,
      list: entries, hasMore: entries.length >= size,
      page: page, size: size,
    );
  }

  void nextPage({String word = ""}) async {
    final pageInfo = state.requireValue;
    if (pageInfo.isLoadingMore) return;
    state = AsyncData(pageInfo.copyWith(isLoadingMore: true));

    final nextPage = pageInfo.page + 1;
    var builder = pageInfo.builder!;
    if (word.isNotEmpty) {
      builder = builder.copyWith(word: word);
      _searchDao.save(word);
    }

    final entries = await _entryRepository.fetchEntries(nextPage, pageInfo.size, builder);
    state = AsyncData(pageInfo.appendList(entries,
      hasMore: entries.length >= pageInfo.size,
      builder: builder, page: nextPage,
    ));
  }

}