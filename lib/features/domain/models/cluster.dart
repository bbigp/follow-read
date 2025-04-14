

import 'package:follow_read/config/icons.dart';

import 'constants.dart';

class Cluster {

  final int id;
  final String name;
  final String icon;
  final List<int> feedIds;
  final int recentTime;
  final List<String> statuses;
  final int deleted;
  final DateTime? createdAt;
  final DateTime? changedAt;
  final int count;

  final bool hideGlobally;
  final String order;
  final bool showReadingTime;
  final bool onlyShowUnread;

  String get svgIcon {
    return ClusterIcons.icon(icon);
  }


  const Cluster({
    this.id = 0, this.name = "", this.icon = "",
    this.recentTime = 0,
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
  });

  Cluster copyWith({
    int? id,
    String? name,
    String? icon,
    List<int>? feedIds,
    int? recentTime,
    List<String>? statuses,
    int? deleted,
    DateTime? createdAt,
    DateTime? changedAt,
    int? count,
    bool? hideGlobally,
    String? order,
    bool? showReadingTime,
    bool? onlyShowUnread,
  }) {
    return Cluster(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      feedIds: feedIds ?? this.feedIds,
      recentTime: recentTime ?? this.recentTime,
      statuses: statuses ?? this.statuses,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      count: count ?? this.count,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      order: order ?? this.order,
      showReadingTime: showReadingTime ?? this.showReadingTime,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
    );
  }

}