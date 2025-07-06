


class SyncRecord {
  final int id;
  final String status;
  final DateTime time;
  final String errorMsg;
  final DateTime? startTime;
  final DateTime? endTime;
  final int entry;
  final int feed;
  final int category;

  SyncRecord({this.id=0, this.status = "ok", this.errorMsg = "",
    DateTime? time,
    this.startTime, this.endTime,
    this.entry = 0, this.feed = 0, this.category = 0,
  }) : time = time ?? DateTime.now();
}