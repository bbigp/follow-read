

import 'package:flutter/cupertino.dart';
import 'package:follow_read/data/model/media.dart';
import 'package:follow_read/data/model/page_info.dart';
import 'package:follow_read/data/providers/miniflux/entry_page_response.dart';
import 'package:follow_read/data/repositories/app_database.dart';
import 'package:html/parser.dart' as html;

import 'feed.dart';
import 'folder.dart';

enum EntryStatus {
  unread, read, removed;

  static EntryStatus fromString(String value) {
    switch (value) {
      case 'removed':
        return EntryStatus.removed;
      case 'read':
        return EntryStatus.read;
      case 'unread':
      default:
        return EntryStatus.unread;
    }
  }
}

class Entry {
  final BigInt id;
  final BigInt userId;
  final BigInt feedId;
  final EntryStatus status;
  final String hash;
  final String title;
  final String url;
  final DateTime publishedAt;
  final String content;
  final String author;
  final bool starred;
  final int readingTime;
  final Feed feed;
  final Folder folder;
  final String summary;
  final DateTime createdAt;
  final DateTime changedAt;
  final List<Media> medias;

  static Entry empty = Entry();

  bool isNull() {
    return id == BigInt.zero;
  }

  bool get isUnread => status == EntryStatus.unread;

  Entry({
    BigInt? id,
    this.title = "",
    this.hash = "",
    BigInt? userId,
    BigInt? feedId,
    EntryStatus? status,
    String? url,
    DateTime? publishedAt,
    String? content,
    String? author,
    bool? starred,
    int? readingTime,
    Feed? feed,
    Folder? folder,
    String? summary,
    DateTime? createdAt,
    DateTime? changedAt,
    this.medias = const [],
  })  : id = id ?? BigInt.zero,
        userId = userId ?? BigInt.zero,
        feedId = feedId ?? BigInt.zero,
        status = status ?? EntryStatus.unread,
        url = url ?? "",
        publishedAt = publishedAt ?? DateTime.now(),
        content = content ?? "<div></div>",
        author = author ?? "",
        starred = starred ?? false,
        readingTime = readingTime ?? 0,
        feed = feed ?? Feed.empty,
        folder = folder ?? Folder.empty,
        summary = summary ?? "",
        createdAt = createdAt ?? DateTime.now(),
        changedAt = changedAt ?? DateTime.now();

  //封面图
  String get pic {
    return medias.firstWhere((e) => e.isImage, orElse: () => Media.empty).url;
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

  Entry copyWith({
    BigInt? id,
    BigInt? userId,
    BigInt? feedId,
    EntryStatus? status,
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
    Folder? folder,
    String? summary,
    DateTime? createdAt,
    DateTime? changedAt,
    List<Media>? medias,
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
      folder: folder ?? this.folder,
      summary: summary ?? this.summary,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      medias: medias ?? this.medias,
    );
  }
}

extension EntryRowExtension on EntryRow {
  Entry toEntry() {
    return Entry(
      id: id, userId: userId, feedId: feedId,
      title: title, hash: hash, content: content, summary: summary,
      status: EntryStatus.fromString(status),
      url: url, author: author, readingTime: readingTime,
      starred: starred,
      publishedAt: publishedAt, createdAt: createdAt, changedAt: changedAt,
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
      feed: feed?.toFeed(), folder: feed?.category?.toFolder(),
      status: EntryStatus.fromString(status),
      medias: (enclosures ?? []).map((e) => e.toMedia()).toList(),
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