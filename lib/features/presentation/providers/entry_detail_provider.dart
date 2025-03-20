


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/entry_repository.dart';
import '../../domain/models/entry.dart';
import 'app_container.dart';

final entryDetailProvider = StateNotifierProvider<EntryDetailNotifier, EntryDetailState>((ref) {
  return EntryDetailNotifier(entryRepository: ref.watch(entryRepositoryProvider));
});

class EntryDetailNotifier extends StateNotifier<EntryDetailState> {

  final EntryRepository _entryRepository;
  EntryDetailNotifier({required EntryRepository entryRepository})
      : _entryRepository = entryRepository, super(EntryDetailState.empty());

  Future<void> fetchEntry(int entryId) async {
    state = state.copyWith(isLoading: true, entryId: entryId);
    final entry = await _entryRepository.getEntry(state.entryId);
    state = state.copyWith(isLoading: false, entry: entry);
  }

}


class EntryDetailState {
  final int entryId;
  final Entry entry;
  final bool isLoading;

  EntryDetailState({required this.entry, required this.isLoading,
    required this.entryId,
  });

  factory EntryDetailState.empty() => EntryDetailState(
      entryId: 0,
    entry: Entry(id: 0, title: '', hash: ''),
    isLoading: false,
  );


  EntryDetailState copyWith({
    Entry? entry,
    bool? isLoading,
    int? entryId,
  }) {
    return EntryDetailState(
      entry: entry ?? this.entry,
      isLoading: isLoading ?? this.isLoading,
        entryId: entryId ?? this.entryId,
    );
  }

}