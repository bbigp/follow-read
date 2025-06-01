


import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/constants.dart';

import '../../data/repositories/entry_repository.dart';
import '../../domain/models/entry.dart';
import 'app_container.dart';

final entryProvider = AsyncNotifierProvider.autoDispose.family<EntryNotifier, Entry, int>(
    EntryNotifier.new,
);

class EntryNotifier extends AutoDisposeFamilyAsyncNotifier<Entry, int> {

  late final _entryRepository = ref.watch(entryRepositoryProvider);

  @override
  FutureOr<Entry> build(int arg) async {
    return await _entryRepository.getEntry(arg);
  }

  Future<void> starred() async {
    final entry = state.requireValue;
    final success = await _entryRepository.starred(arg, !entry.starred);
    if (success) {
      state = AsyncData(entry.copyWith(starred: !entry.starred));
      return;
    }
  }

  Future<void> read() async {
    final entry = state.requireValue;
    final status = entry.status == Model.read ? Model.unread : Model.read;
    final success = await _entryRepository.updateStatus(arg, status);
    if (success) {
      state = AsyncData(entry.copyWith(status: status));
    }
  }

}