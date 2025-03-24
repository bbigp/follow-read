import 'package:follow_read/features/domain/models/ui_item.dart';


class Feed extends BaseUiItem {
  final int id;
  final int userId;
  final String feedUrl;
  final String siteUrl;
  final String title;
  final int unread;
  final int read;
  final String iconUrl;
  final bool onlyUnread;

  Feed({
    required this.id,
    required this.userId,
    required this.feedUrl,
    required this.siteUrl,
    required this.title,
    this.unread = 0,
    this.read = 0 ,
    this.iconUrl = "",
    this.onlyUnread = false,
  });

  Feed copyWith({
    int? id,
    int? userId,
    String? feedUrl,
    String? siteUrl,
    String? title,
    int? unread,
    int? read,
    String? iconUrl,
    bool? onlyUnread,
  }) {
    return Feed(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      unread: unread ?? this.unread,
      read: read ?? this.read,
      iconUrl: iconUrl ?? this.iconUrl,
      onlyUnread: onlyUnread ?? this.onlyUnread,
    );
  }

  static Feed empty = Feed(id: 0, userId: 0, feedUrl: "", siteUrl: "", title: "");
}


