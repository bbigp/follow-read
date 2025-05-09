

import 'package:follow_read/config/icons.dart';

import 'constants.dart';

class Cluster {

  final int id;
  final String name;
  final String icon;
  final List<int> feedIds;
  final int recentTime;
  final int recentAddTime;
  final List<String> statuses;
  final int deleted;
  final DateTime? createdAt;
  final DateTime? changedAt;
  final int count;
  final int starred;

  final bool hideGlobally;
  final String order;
  final bool showReadingTime;
  final bool onlyShowUnread;

  String get svgIcon {
    return ClusterIcons.icon(icon);
  }

  static const recentOptions = {0: 'Off', 1440: '最近24小时', 2880: '最近48小时',
    10080: '最近一周', 40320: '最近一个月'};

  static String toRecentOption(int time) {
    return recentOptions[time] ?? 'Off';
  }

  static int toRecentTime(String option){
    return recentOptions.entries
        .firstWhere((e) => e.value == option, orElse: () => const MapEntry(0, 'Off'))
        .key;
  }


  const Cluster({
    this.id = 0, this.name = "", this.icon = "",
    this.recentTime = 0,
    this.recentAddTime = 0,
    this.deleted = 0,
    this.feedIds = const [],
    this.statuses = const [],
    this.createdAt,
    this.changedAt,
    this.count = 0,
    this.hideGlobally = false,
    this.order = Frc.orderxPublishedAt,
    this.showReadingTime = false,
    this.onlyShowUnread = false,
    this.starred = -1,
  });

  Cluster copyWith({
    int? id,
    String? name,
    String? icon,
    List<int>? feedIds,
    int? recentTime,
    int? recentAddTime,
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
    return Cluster(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      feedIds: feedIds ?? this.feedIds,
      recentTime: recentTime ?? this.recentTime,
      recentAddTime: recentAddTime ?? this.recentAddTime,
      statuses: statuses ?? this.statuses,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      count: count ?? this.count,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      order: order ?? this.order,
      showReadingTime: showReadingTime ?? this.showReadingTime,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      starred: starred ?? this.starred,
    );
  }

  @override
  String toString() {
    return 'Cluster{id: $id, name: $name, icon: $icon, feedIds: $feedIds, recentTime: $recentTime, statuses: $statuses, deleted: $deleted, createdAt: $createdAt, changedAt: $changedAt, count: $count, starred: $starred, hideGlobally: $hideGlobally, order: $order, showReadingTime: $showReadingTime, onlyShowUnread: $onlyShowUnread}';
  }
}