
import 'package:follow_read/data/repositories/app_database.dart';

import 'entry.dart';

enum PendingChangeAction {
  markAsRead, markAsUnread, markAsRemoved,
  markAsStarred,
}

extension EntryStatusToPendingAction on EntryStatus {
  PendingChangeAction? toPendingAction() {
    switch (this) {
      case EntryStatus.read:
        return PendingChangeAction.markAsRead;
      case EntryStatus.unread:
        return PendingChangeAction.markAsUnread;
      case EntryStatus.removed:
        return PendingChangeAction.markAsRemoved;
    }
  }
}

// status 的可能值
enum PendingChangeStatus {
  pending,
  success,
  failed,
}

class PendingChange {
  final int id;
  final BigInt userId;
  final String contentId;
  final PendingChangeAction action;
  final PendingChangeStatus status;
  final String extra;
  final DateTime createdAt;
  final DateTime? executeTime;
  final String msg;


  PendingChange({
    int? id,
    required this.userId,
    required this.contentId,
    required this.action,
    PendingChangeStatus? status,
    String? extra,
    DateTime? createdAt,
    this.executeTime,
    String? msg,
  })  : id = id ?? 0,
        status = status ?? PendingChangeStatus.pending,
        extra = extra ?? "",
        createdAt = createdAt ?? DateTime.now(),
        msg = msg ?? "";


  PendingChange copyWith({
    int? id,
    BigInt? userId,
    String? contentId,
    PendingChangeAction? action,
    PendingChangeStatus? status,
    String? extra,
    DateTime? createdAt,
    DateTime? executeTime,
    String? msg,
  }) {
    return PendingChange(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      contentId: contentId ?? this.contentId,
      action: action ?? this.action,
      status: status ?? this.status,
      extra: extra ?? this.extra,
      createdAt: createdAt ?? this.createdAt,
      executeTime: executeTime ?? this.executeTime,
      msg: msg ?? this.msg,
    );
  }

}

extension PendingChangeRowExtension on PendingChangeRow {
  PendingChange to() {
    return PendingChange(
      id: id, userId: userId, contentId: contentId, action: action,
      status: status, extra: extra, createdAt: createdAt,
      executeTime: executeTime, msg: msg,
    );
  }
}
