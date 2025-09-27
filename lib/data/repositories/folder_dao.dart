


import 'package:drift/drift.dart';
import 'package:follow_read/data/model/folder.dart';

import 'app_database.dart';

class FolderDao extends DatabaseAccessor<AppDatabase> {

  FolderDao(super.attachedDatabase);

  $FoldersTableTable get foldersTable => attachedDatabase.foldersTable;


  Future<List<Folder>> getAllFolders() async {
    var query = select(foldersTable);
    query = query
      ..orderBy([(t) => OrderingTerm(expression: foldersTable.id, mode: OrderingMode.asc)]);
    final rows = await query.get();
    return rows.map((e) => e.toFolder()).toList();
  }

  Future<Folder?> getFolder(BigInt id) async {
    var query = select(foldersTable);
    query = query..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }
    return row.toFolder();
  }


  Future<void> batchSave(List<Folder> folders) async {
    if (folders.isEmpty) return;

    final buffer = StringBuffer();
    buffer.write('INSERT INTO folders (id, user_id, title, hide_globally) VALUES ');

    final args = <Object?>[];
    for (int i = 0; i < folders.length; i++) {
      buffer.write('(?, ?, ?, ?)');
      if (i < folders.length - 1) buffer.write(', ');
      args.addAll([
        folders[i].id, folders[i].userId, folders[i].title, folders[i].hideGlobally,
      ]);
    }
    buffer.write(' ON CONFLICT(id) DO UPDATE SET '
        'title = excluded.title, hide_globally = excluded.hide_globally'
    );
    await customStatement(buffer.toString(), args);
  }

}