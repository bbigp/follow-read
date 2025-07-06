

import 'package:follow_read/data/providers/miniflux/feed_response.dart';

class Feed {

  final int id;
  final int userId;
  final String feedUrl;
  final String siteUrl;
  final String title;
  final int errorCount;
  final String errorMsg;
  final int categoryId;
  final bool hideGlobally;

  final String iconUrl;
  final bool onlyShowUnread;
  final String order;

  final int unread;
  final int read;

  static Feed empty = Feed();

  const Feed({
    this.id = 0,
    this.userId = 0,
    this.feedUrl = "",
    this.siteUrl = "",
    this.title = "",
    this.unread = 0,
    this.read = 0 ,
    this.iconUrl = "",
    this.onlyShowUnread = false,
    this.errorCount = 0,
    this.errorMsg = "",
    this.categoryId = 0,
    this.order = "",
    this.hideGlobally = false,
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
    bool? onlyShowUnread,
    bool? showReadingTime,
    int? errorCount,
    String? errorMsg,
    int? categoryId,
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
      categoryId: categoryId ?? this.categoryId,
      order: order ?? this.order,
      hideGlobally: hideGlobally ?? this.hideGlobally,
    );
  }
}

extension FeedResponseExtension on FeedResponse {
  Feed toFeed(){
    return Feed(
      id: id, userId: userId, feedUrl: feedUrl, siteUrl: siteUrl,
      errorMsg: parsingErrorMessage, errorCount: parsingErrorCount,
      categoryId: category == null ? 0 : category!.id,
      hideGlobally: hideGlobally ?? false,

      onlyShowUnread: false,
      order: "desc",
      iconUrl: icon == null ? "" : "icons/${icon?.iconId}",
    );
  }
}