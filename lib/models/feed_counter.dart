
class FeedCounter {
  final Map<String, int> reads;
  final Map<String, int> unreads;

  FeedCounter({
    required this.reads,
    required this.unreads,
  });

  factory FeedCounter.fromJson(Map<String, dynamic> json) {
    return FeedCounter(
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

  @override
  String toString() {
    return 'FeedCounter(reads: $reads, unreads: $unreads)';
  }
}
