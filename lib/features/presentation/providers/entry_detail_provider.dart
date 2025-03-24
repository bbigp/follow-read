


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

  Future<bool> read() async {
    return entryRepository.updateStatus(entryId, 'read');
  }

}


class EntryDetailState {
  final Entry entry;
  final bool isLoading;

  EntryDetailState({required this.entry, required this.isLoading,});

  factory EntryDetailState.empty() => EntryDetailState(
    entry: Entry(id: 0, title: '', hash: ''),
    isLoading: false,
  );


  EntryDetailState copyWith({
    Entry? entry,
    bool? isLoading,
  }) {
    return EntryDetailState(
      entry: entry ?? this.entry,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}