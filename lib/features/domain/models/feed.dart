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

  Feed({
    required this.id,
    required this.userId,
    required this.feedUrl,
    required this.siteUrl,
    required this.title,
    int? unread,
    int? read,
    String? iconUrl,
  })  : unread = unread ?? 0,
        read = read ?? 0,
        iconUrl = iconUrl ?? "";

  static Feed empty = Feed(id: 0, userId: 0, feedUrl: "", siteUrl: "", title: "");
}


