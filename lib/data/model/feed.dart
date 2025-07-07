

import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/providers/miniflux/feed_response.dart';
import 'package:follow_read/data/repositories/app_database.dart';

class Feed {

  final BigInt id;
  final BigInt userId;
  final String feedUrl;
  final String siteUrl;
  final String title;
  final int errorCount;
  final String errorMsg;
  final BigInt folderId;
  final bool hideGlobally;

  final String iconUrl;
  final bool onlyShowUnread;
  final String order;

  final int unread;
  final int read;

  static Feed empty = Feed();

  Feed({
    BigInt? id,
    BigInt? userId,
    this.feedUrl = "",
    this.siteUrl = "",
    this.title = "",
    this.unread = 0,
    this.read = 0 ,
    this.iconUrl = "",
    this.onlyShowUnread = false,
    this.errorCount = 0,
    this.errorMsg = "",
    BigInt? folderId,
    this.order = "",
    this.hideGlobally = false,
  }) :  id = id ?? BigInt.zero,
        userId = userId ?? BigInt.zero,
        folderId = folderId ?? BigInt.zero;

  Feed copyWith({
    BigInt? id,
    BigInt? userId,
    String? feedUrl,
    String? siteUrl,
    String? title,
    int? unread,
    int? read,
    String? iconUrl,
    bool? onlyShowUnread,
    bool? showReadingTime,
    int? errorCount,
    String? errorMsg,
    BigInt? folderId,
    String? order,
    bool? hideGlobally,
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
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      errorCount: errorCount ?? this.errorCount,
      errorMsg: errorMsg ?? this.errorMsg,
      folderId: folderId ?? this.folderId,
      order: order ?? this.order,
      hideGlobally: hideGlobally ?? this.hideGlobally,
    );
  }
}

extension FeedRowExtension on FeedRow {
  Feed toFeed() {
    return Feed(
      id: id, userId: userId, feedUrl: feedUrl, siteUrl: siteUrl,
      title: title, iconUrl: iconUrl, onlyShowUnread: onlyShowUnread,
      errorMsg: errorMsg, errorCount: errorCount, folderId: folderId,
      order: orderx, hideGlobally: hideGlobally,
    );
  }
}

extension FeedResponseExtension on FeedResponse {
  Feed toFeed(){
    return Feed(
      id: id, userId: userId, feedUrl: feedUrl, siteUrl: siteUrl,
      errorMsg: parsingErrorMessage, errorCount: parsingErrorCount,
      folderId: category?.id, title: title,
      hideGlobally: hideGlobally ?? false,

      onlyShowUnread: false,
      order: "desc",
      iconUrl: icon == null ? "" : "icons/${icon?.iconId}",
    );
  }
}