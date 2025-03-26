


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/entry_repository.dart';
import '../../domain/models/entry.dart';
import 'app_container.dart';

final entryDetailProvider = StateNotifierProvider.autoDispose.family<
    EntryDetailNotifier, EntryDetailState, int
>((ref, entryId) {
  return EntryDetailNotifier(
    entryId: entryId,
    entryRepository: ref.watch(entryRepositoryProvider),
  );
});

class EntryDetailNotifier extends StateNotifier<EntryDetailState> {

  final EntryRepository entryRepository;
  final int entryId;
  EntryDetailNotifier({
    required this.entryId,
    required this.entryRepository
  }) : super(EntryDetailState.empty()) {
    fetchEntry();
  }

  Future<void> fetchEntry() async {
    state = state.copyWith(isLoading: true);
    final entry = await entryRepository.getEntry(entryId);
    state = state.copyWith(isLoading: false, entry: entry);
  }

  Future<bool> read(String status) async {
    final success = await entryRepository.updateStatus(entryId, status);
    if (success) {
      state = state.copyWith(entry: state.entry.copyWith(status: status));
    } else {
      state = state.copyWith(errorMsg: "");
    }
    return success;
  }

  Future<void> starred(bool starred) async {
    final success = await entryRepository.starred(entryId, starred);
    if (success) {
      state = state.copyWith(entry: state.entry.copyWith(starred: starred));
      return;
    }
    state = state.copyWith(errorMsg: "");
  }

}


class EntryDetailState {
  final Entry entry;
  final bool isLoading;
  final String errorMsg;

  EntryDetailState({required this.entry, required this.isLoading, required this.errorMsg});

  factory EntryDetailState.empty() => EntryDetailState(
    entry: Entry(id: 0, title: '', hash: ''),
    isLoading: false, errorMsg: "",
  );


  EntryDetailState copyWith({
    Entry? entry,
    bool? isLoading,
    String? errorMsg,
  }) {
    return EntryDetailState(
      entry: entry ?? this.entry,
      isLoading: isLoading ?? this.isLoading,
        errorMsg: errorMsg ?? this.errorMsg,
    );
  }

}