

import 'package:drift/drift.dart';
import 'package:follow_read/data/model/media.dart';

import 'app_database.dart';

class MediaDao extends DatabaseAccessor<AppDatabase> {

  MediaDao(super.attachedDatabase);

  $MediasTableTable get mediasTable => attachedDatabase.mediasTable;

  Future<Map<BigInt, List<Media>>> mediaMapByEntryIds(List<BigInt> entryIds) async {
    var query = select(mediasTable);
    query = query..where((t) => t.entryId.isIn(entryIds));
    final rows = await query.get();
    final medias = rows.map((e) => e.toMedia()).toList();

    final Map<BigInt, List<Media>> mediaMap = {};
    for (final media in medias) {
      mediaMap.putIfAbsent(media.entryId, () => []).add(media);
    }
    return mediaMap;
  }


  Future<void> batchSave(List<Media> medias) async {
    if (medias.isEmpty) return;

    final buffer = StringBuffer();
    buffer.write('INSERT INTO medias (id, user_id, entry_id, url, mime_type, size) VALUES ');

    final args = <Object?>[];
    for (int i = 0; i < medias.length; i++) {
      buffer.write('(?, ?, ?, ?, ?, ?)');
      if (i < medias.length - 1) buffer.write(', ');
      args.addAll([
        medias[i].id, medias[i].userId, medias[i].entryId, medias[i].url, medias[i].mimeType,
        medias[i].size,
      ]);
    }
    buffer.write(' ON CONFLICT(id) DO nothing');
    await customStatement(buffer.toString(), args);
  }

}