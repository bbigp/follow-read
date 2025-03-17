import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/features/data/datasources/database.dart';

part 'feed.mapper.dart';

@MappableClass(ignoreNull: true)
class Feed with FeedMappable {
  final BigInt id;
  @MappableField(key: 'user_id')
  final BigInt userId;
  @MappableField(key: 'feed_url')
  final String feedUrl;
  @MappableField(key: 'site_url')
  final String siteUrl;
  final String title;
  final String? avatarUrl;
  final int unread;
  final int read;
  final ViewType viewType;
  final IconData iconData;

  Feed({
    required this.id,
    required this.userId,
    required this.feedUrl,
    required this.siteUrl,
    required this.title,
    this.avatarUrl,
    int? unread,
    int? read,
    ViewType? viewType,
    IconData? iconData,
  })  : unread = unread ?? 0,
        read = read ?? 0,
        viewType = viewType ?? ViewType.feedItem,
        iconData = iconData ?? Icons.ac_unit_outlined;
}

enum ViewType {
  feedItem,
  groupTitleItem,
  listItem,
  divider32,
}
