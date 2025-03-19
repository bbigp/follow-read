import 'package:flutter/material.dart';
import 'package:follow_read/features/domain/models/ui_item.dart';


class Feed extends BaseUiItem {
  final int id;
  final int userId;
  final String feedUrl;
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

  static Feed empty = Feed(id: 0, userId: 0, feedUrl: "", siteUrl: "", title: "");
}


