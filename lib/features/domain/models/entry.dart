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
  final String url;
  final DateTime publishedAt;
  final String content;
  final String author;
  final bool starred;
  final int readingTime;
  final Feed feed;
  final String summary;

  Entry({
    required this.id,
    required this.title,
    required this.hash,
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
    String? summary,
  })  : userId = userId ?? 0,
        feedId = feedId ?? 0,
        status = status ?? "unread",
        url = url ?? "",
        publishedAt = publishedAt ?? DateTime.now(),
        content = content ?? "<div></div>",
        author = author ?? "",
        starred = starred ?? false,
        readingTime = readingTime ?? 0,
        feed = feed ?? Feed.empty,
        summary = summary ?? "";

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

  bool get isUnread {
    return status == 'unread';
  }

  List<String> get allImageUrls {
    final doc = html.parse(content);
    return doc.querySelectorAll('img').map((img) {
      return img.attributes['src'] ?? '';
    }).where((src) => src.isNotEmpty).toList();
  }

  String get description {
    try {
      final document = html.parse(content);
      final element = document.body ?? document.documentElement;
      String text = element?.text ?? '';
      text = text
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
      return text.isEmpty
          ? ''
          : text.substring(0, text.length.clamp(0, 200)) +
          (text.length > 200 ? '...' : '');
    } catch (e) {
      return "";
    }
  }

  int getTilteLines(bool showReadingTime) {
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
    String? summary,
  }) {
    return Entry(
      id: id ?? this.id,
      title: title ?? this.title,
      hash: hash ?? this.hash,
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
      summary: summary ?? this.summary,
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
