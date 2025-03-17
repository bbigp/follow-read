import 'package:follow_read/features/domain/models/view_type.dart';

class Entry {
  final BigInt id;
  final BigInt userId;
  final BigInt feedId;
  final String status;
  final String hash;
  final String title;
  final String description;
  final String url;
  final String publishedAt;
  final String content;
  final String author;
  final bool starred;
  final int readingTime;
  final String pic;

  final String feedTitle;
  final String feedIcon;
  final bool showReadingTime;
  final ViewType viewType;

  Entry({
    required this.id,
    required this.title,
    required this.hash,
    String? description,
    BigInt? userId,
    BigInt? feedId,
    String? status,
    String? url,
    String? publishedAt,
    String? content,
    String? author,
    bool? starred,
    int? readingTime,
    String? pic,
    String? feedTitle,
    String? feedIcon,
    bool? showReadingTime,
    ViewType? viewType,
  })  : userId = userId ?? BigInt.zero,
        feedId = feedId ?? BigInt.zero,
        status = status ?? "unread",
        url = url ?? "",
        publishedAt = publishedAt ?? "",
        content = content ?? "<div></div>",
        author = author ?? "",
        starred = starred ?? false,
        readingTime = readingTime ?? 0,
        description = description ?? "",
        pic = pic ?? "",
        feedTitle = feedTitle ?? "",
        feedIcon = feedIcon ?? "",
        showReadingTime = showReadingTime ?? false,
        viewType = viewType ?? ViewType.entryItem;

  int get tilteLines {
    if (showReadingTime) {
      if (pic != '' && description == '') {
        return 2;
      }
      return 1;
    } else {
      return 2;
    }
  }
}
