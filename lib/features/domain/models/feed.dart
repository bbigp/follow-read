
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
  final int unreadCount;
  final ViewType viewType;
  final IconData iconData;

  Feed({
    required this.id,
    required this.userId,
    required this.feedUrl,
    required this.siteUrl,
    required this.title,
    this.avatarUrl,
    this.unreadCount = 0,
    this.viewType = ViewType.feedItem,
    this.iconData = Icons.ac_unit_outlined,
  });

  factory Feed.fromEntity(FeedEntity feed) {
    return Feed(
      id: feed.id,
      title: feed.title,
      userId: feed.userId,
      feedUrl: feed.feedUrl,
      siteUrl: feed.siteUrl,
      avatarUrl: "",
      unreadCount: 10,
      viewType: ViewType.feedItem,
    );
  }
}

enum ViewType {
  feedItem,
  groupTitleItem,
  listItem,
  divider32,




}