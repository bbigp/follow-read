



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/view_type.dart';



final entriesLoadingProvider = StateNotifierProvider<EntriesLoadingNotifier, EntryListState>((ref) {
  return EntriesLoadingNotifier();
});

class EntriesLoadingNotifier extends StateNotifier<EntryListState> {

  EntriesLoadingNotifier()
      : super(EntryListState.initial());

  var title = 'The best last-minute Cyber Monday you can still shop';
  var desc = 'There’s still some time to save on a wide range of Verge-approved goods, including streaming services, iPads, and ebook readers.';
  var url = 'https://i1.hdslb.com/bfs/article/26c34746fceeeea24c72fdba06fe006757276677.png@1192w.avif';
  var url2 = 'https://i1.hdslb.com/bfs/article/b5a29a9b8ad1aba8b45e64fa505e410357276677.png@1192w.avif';

  Future<void> fetchEntry() async {
    final list = <Entry>[];
    final e0 = Entry(id: BigInt.from(1), title: title, hash: '2', viewType: ViewType.entryAllItem);
    final e1 = Entry(id: BigInt.from(1), hash: '1', title: title, description: desc, feedTitle: 'Youtube', feedIcon: url, publishedAt: '2h', readingTime: 5, pic: url2);
    final e2 = Entry(id: BigInt.from(2), hash: '2', title: title, description: desc, feedTitle: 'NTS Radio', feedIcon: url, publishedAt: '2h', readingTime: 5, pic: url2, showReadingTime: true);
    final e3 = Entry(id: BigInt.from(2), hash: '2', title: title, feedTitle: 'Hacker News', feedIcon: url, publishedAt: '2h', readingTime: 5, showReadingTime: false);
    final e4 = Entry(id: BigInt.from(2), hash: '2', title: title, feedTitle: 'NTS Radio', feedIcon: url, publishedAt: '2h', readingTime: 5, pic: url2, showReadingTime: true);
    final e5 = Entry(id: BigInt.from(2), title: title, hash: 'ss', viewType: ViewType.noMore);
    list.addAll([e0, e1, e2, e3, e4, e5]);
    state = state.copyWith(entries: list);
  }


}


class EntryListState {
  final List<Entry> entries;
  final int page;
  final int size;

  const EntryListState({required this.entries, required this.page, required this.size});

  const EntryListState.initial()
      : entries = const <Entry>[],
        page = 1, size = 10;


  EntryListState copyWith({
    List<Entry>? entries,
    int? page,
    int? size,
  }) {
    return EntryListState(
      entries: entries ?? this.entries,
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

}