
class FeedCounterResponse {
  final Map<String, int> reads;
  final Map<String, int> unreads;

  FeedCounterResponse({
    required this.reads,
    required this.unreads,
  });

  factory FeedCounterResponse.fromJson(Map<String, dynamic> json) {
    return FeedCounterResponse(
      reads: Map<String, int>.from(json['reads'] as Map),
      unreads: Map<String, int>.from(json['unreads'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reads': reads,
      'unreads': unreads,
    };
  }

  List<FeedCounter> toConters() {
    Map<BigInt, FeedCounter> map = {};
    final allKeys = {...reads.keys, ...unreads.keys};
    for (final key in allKeys) {
      final id = BigInt.parse(key);
      final readCount = reads[key] ?? 0;    // 读取已读数（不存在则默认为0）
      final unreadCount = unreads[key] ?? 0; // 读取未读数（不存在则默认为0）

      map[id] = FeedCounter(
        id: id,
        read: readCount,
        unread: unreadCount,
      );
    }
    return map.values.toList();
  }

  @override
  String toString() {
    return 'FeedCounter(reads: $reads, unreads: $unreads)';
  }
}

class FeedCounter {
  final BigInt id;
  final int read;
  final int unread;

  FeedCounter({required this.id, required this.read, required this.unread});
}

