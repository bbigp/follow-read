
import 'package:follow_read/features/data/models/entry_page_response.dart';
import 'package:follow_read/features/domain/models/entry.dart';

import '../datasources/api_client.dart';

class EntryRepository {

  Future<List<Entry>> getEntries(int feedId, int page, int size) async {
    final result = await ApiClient.getEntries(feedId, page: page, size: size);
    return result.fold((failure) {
      return [];
    }, (data) {
      return data.entries.map((item) => item.toModel()).toList();
    });
  }


  Future<Entry> getEntry(int entryId) async {
    final result = await ApiClient.getEntry(entryId);
    return result.fold((failure) {
      return Entry(id: 0, title: '', hash: '');
    }, (data) {
      return data.toModel();
    });
  }

}