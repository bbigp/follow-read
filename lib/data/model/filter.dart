

import 'package:follow_read/data/repositories/app_database.dart';

class Filter {

  final BigInt id;
  final String name;
  final String icon;
  final BigInt userId;
  final List<BigInt> feedIds;
  final int publishedTime;
  final int addTime;
  final List<String> statuses;
  final int deleted;
  final DateTime createdAt;
  final DateTime changedAt;
  final bool hideGlobally;
  final String order;
  final bool onlyShowUnread;

  Filter({
    BigInt? id,
    BigInt? userId,
    this.name = "", this.icon = "",
    this.feedIds = const [],
    this.publishedTime = 0,
    this.addTime = 0,
    this.statuses = const [],
    this.deleted = 0,
    DateTime? createdAt,
    DateTime? changedAt,
    this.hideGlobally = false,
    this.order = "publishedTime",
    this.onlyShowUnread = false,
  }) : id = id ?? BigInt.zero,
      userId = userId ?? BigInt.zero,
      createdAt = createdAt ?? DateTime.now(),
      changedAt = createdAt ?? DateTime.now();

  Filter copyWith({
    BigInt? id,
    BigInt? userId,
    String? name,
    String? icon,
    List<BigInt>? feedIds,
    int? publishedTime,
    int? addTime,
    List<String>? statuses,
    int? deleted,
    DateTime? createdAt,
    DateTime? changedAt,
    int? count,
    bool? hideGlobally,
    String? order,
    bool? showReadingTime,
    bool? onlyShowUnread,
    int? starred,
  }) {
    return Filter(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      feedIds: feedIds ?? this.feedIds,
      publishedTime: publishedTime ?? this.publishedTime,
      addTime: addTime ?? this.addTime,
      statuses: statuses ?? this.statuses,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      order: order ?? this.order,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
    );
  }

}

extension FilterRowExtension on FilterRow {
  Filter toFilter() {
    return Filter(
      id: id, userId: userId, name: name, icon: icon,
      feedIds: feedIds.split(",").where((s) => s.isNotEmpty).map(BigInt.parse).toList(),
      publishedTime: publishedTime, addTime: addTime, onlyShowUnread: onlyShowUnread,
      deleted: deleted, createdAt: createdAt, changedAt: changedAt,
      order: orderx, hideGlobally: hideGlobally,
      statuses: statuses.split(",").where((s) => s.isNotEmpty).toList(),
    );
  }
}