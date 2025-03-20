import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/ui_item.dart';
import 'package:html/parser.dart' as html;

class Entry extends BaseUiItem {
  final int id;
  final int userId;
  final int feedId;
  final String status;
  final String hash;
  final String title;
  final String description;
  final String url;
  final DateTime publishedAt;
  final String content;
  final String author;
  final bool starred;
  final int readingTime;
  late final Feed feed;

  final bool showReadingTime;

  Entry({
    required this.id,
    required this.title,
    required this.hash,
    String? description,
    int? userId,
    int? feedId,
    String? status,
    String? url,
    DateTime? publishedAt,
    String? content,
    String? author,
    bool? starred,
    int? readingTime,
    Feed? feed,
    bool? showReadingTime,
  })  : userId = userId ?? 0,
        feedId = feedId ?? 0,
        status = status ?? "unread",
        url = url ?? "",
        publishedAt = publishedAt ?? DateTime.now(),
        content = content ?? "<div></div>",
        author = author ?? "",
        starred = starred ?? false,
        readingTime = readingTime ?? 0,
        description = description ?? "",
        feed = feed ?? Feed.empty,
        showReadingTime = showReadingTime ?? false;

  String get pic {
    try {
      final document = html.parse(content);
      final imgs = document.getElementsByTagName('img');
      if (imgs.isEmpty) return "";

      final firstImg = imgs.first;
      return firstImg.attributes['data-src'] ??
          firstImg.attributes['srcset']?.split(',').first.trim().split(' ').first ??
          firstImg.attributes['src'] ?? "";
    } catch (e) {
      return "";
    }
  }

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

  Entry copyWith({
    int? id,
    int? userId,
    int? feedId,
    String? status,
    String? hash,
    String? title,
    String? description,
    String? url,
    DateTime? publishedAt,
    String? content,
    String? author,
    bool? starred,
    int? readingTime,
    String? pic,
    Feed? feed,
    bool? showReadingTime,
  }) {
    return Entry(
      id: id ?? this.id,
      title: title ?? this.title,
      hash: hash ?? this.hash,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      feedId: feedId ?? this.feedId,
      status: status ?? this.status,
      url: url ?? this.url,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      author: author ?? this.author,
      starred: starred ?? this.starred,
      readingTime: readingTime ?? this.readingTime,
      feed: feed ?? this.feed,
      showReadingTime: showReadingTime ?? this.showReadingTime,
    );
  }
}

extension DateTimeConversion on DateTime{

  String toShowTime() {
    final now = DateTime.now();
    final difference = now.difference(this);
    final units = [
      (value: difference.inDays, unit: "天"),
      (value: difference.inHours % 24, unit: "小时"),
      (value: difference.inMinutes % 60, unit: "分钟"),
    ];

    for (var u in units) {
      if (u.value > 0) {
        return "${u.value}${u.unit}前";
      }
    }
    return "刚刚";
  }
}
