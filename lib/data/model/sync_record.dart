


import 'package:follow_read/data/repositories/app_database.dart';

class SyncRecord {
  final BigInt id;
  final String status;
  final DateTime time;
  final String errorMsg;
  final DateTime? startTime;
  final DateTime? endTime;
  final int entry;
  final int feed;
  final int folder;
  final int media;

  SyncRecord({BigInt? id, this.status = "ok", this.errorMsg = "",
    DateTime? time,
    this.startTime, this.endTime,
    this.entry = 0, this.feed = 0, this.folder = 0, this.media = 0,
  }) : time = time ?? DateTime.now(),
    id = id ?? BigInt.zero
  ;
}

extension SyncRecordRowExtension on SyncRecordRow {
  SyncRecord to() {
    return SyncRecord(
      id: id, status: status, time: time, errorMsg: errorMsg,
      startTime: startTime, endTime: endTime,
      entry: entry,
      feed: feed, folder: folder, media: media,
    );
  }
}