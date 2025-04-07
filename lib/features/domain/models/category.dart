
class Category {

  final int id;
  final String title;
  final int userId;
  final bool hideGlobally;
  final bool onlyShowUnread;
  final bool showReadingTime;


  // final List<Feed> feeds;
  // final bool expanded;

  const Category({
    required this.id,
    required this.title,
    this.userId = 0,
    this.hideGlobally = false,
    this.onlyShowUnread = false,
    this.showReadingTime = false,
    // this.feeds = const [],
    // this.expanded = false,
  });

  // int get unread {
  //   return feeds.fold<int>(0, (sum, feed) => sum + feed.unread);
  // }
  //
  // int get errorCount {
  //   return feeds.fold<int>(0, (sum, feed) => sum + feed.errorCount);
  // }


  Category copyWith({
    int? id,
    String? title,
    int? userId,
    bool? hideGlobally,
    bool? onlyShowUnread,
    bool? showReadingTime,
    // List<Feed>? feeds,
    // bool? expanded,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      showReadingTime: showReadingTime ?? this.showReadingTime,
      // feeds: feeds ?? this.feeds,
      // expanded: expanded ?? this.expanded,
    );
  }

}