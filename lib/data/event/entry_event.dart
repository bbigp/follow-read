


import 'package:follow_read/data/event/app_event.dart';
import 'package:follow_read/data/model/entry.dart';

class EntryStatusEvent extends AppEvent {

  final EntryStatus status;
  final BigInt entryId;
  final BigInt feedId;
  final BigInt folderId;
  EntryStatusEvent({required this.status, required this.entryId,
    required this.feedId, required this.folderId,
  });
}