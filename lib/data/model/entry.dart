

import 'package:follow_read/data/model/page_info.dart';
import 'package:follow_read/data/providers/miniflux/entry_page_response.dart';

import 'feed.dart';

enum EntryState {
  unread, read, removed;

  static EntryState fromString(String value) {
    switch (value) {
      case 'removed':
        return EntryState.removed;
      case 'read':
        return EntryState.read;
      case 'unread':
      default:
        return EntryState.unread;
    }
  }
}

class Entry {
  final int id;
  final int userId;
  final int feedId;
  final EntryState status;
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
  final DateTime createdAt;
  final DateTime changedAt;

  static Entry empty = Entry();

  Entry({
    this.id = 0,
    this.title = "",
    this.hash = "",
    int? userId,
    int? feedId,
    EntryState? status,
    String? url,
    DateTime? publishedAt,
    String? content,
    String? author,
    bool? starred,
    int? readingTime,
    Feed? feed,
    String? summary,
    DateTime? createdAt,
    DateTime? changedAt,
  })  : userId = userId ?? 0,
        feedId = feedId ?? 0,
        status = status ?? EntryState.unread,
        url = url ?? "",
        publishedAt = publishedAt ?? DateTime.now(),
        content = content ?? "<div></div>",
        author = author ?? "",
        starred = starred ?? false,
        readingTime = readingTime ?? 0,
        feed = feed ?? Feed.empty,
        summary = summary ?? "",
        createdAt = createdAt ?? DateTime.now(),
        changedAt = changedAt ?? DateTime.now();

  //封面图
  String get pic {
    // try {
    //   final document = html.parse(content);
    //   final imgs = document.getElementsByTagName('img');
    //   if (imgs.isEmpty) return "";
    //
    //   final firstImg = imgs.first;
    //   return firstImg.attributes['data-src'] ??
    //       firstImg.attributes['srcset']?.split(',').first.trim().split(' ').first ??
    //       firstImg.attributes['src'] ?? "";
    // } catch (e) {
      return "";
    // }
  }

  bool get isUnread {
    return status == EntryState.unread;
  }

  List<String> get allImageUrls {
    // final doc = html.parse(content);
    // return doc.querySelectorAll('img').map((img) {
    //   return img.attributes['src'] ?? '';
    // }).where((src) => src.isNotEmpty).toList();
    return [];
  }

  //描述
  String get description {
    // try {
    //   final document = html.parse(content);
    //   final element = document.body ?? document.documentElement;
    //   String text = element?.text ?? '';
    //   text = text
    //       .replaceAll(RegExp(r'\s+'), ' ')
    //       .trim();
    //   return text.isEmpty
    //       ? ''
    //       : text.substring(0, text.length.clamp(0, 200)) +
    //       (text.length > 200 ? '...' : '');
    // } catch (e) {
      return "";
    // }
  }

  Entry copyWith({
    int? id,
    int? userId,
    int? feedId,
    EntryState? status,
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
    DateTime? createdAt,
    DateTime? changedAt,
  }) {
    return Entry(id: id ?? this.id, title: title ?? this.title,
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
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
    );
  }
}

extension EntryResponseExtension on EntryResponse {
  Entry toEntry() {
    return Entry(
      id: id, title: title, hash: hash, userId: userId, feedId: feedId,
      url: url, publishedAt: publishedAt, content: content,
      author: author, starred: starred, readingTime: readingTime,
      summary: "", createdAt: createdAt, changedAt: changedAt,
      feed: feed?.toFeed(),
      status: EntryState.fromString(status)
    );
  }
}

extension EntryPageResponseExtension on EntryPageResponse {
  PageInfo<Entry> toPageInfo(){
    return PageInfo(
      total: total, list: entries.map((e) => e.toEntry()).toList(),
    );
  }
}