
import 'constants.dart';

class Category {

  final int id;
  final String title;
  final int userId;
  final bool hideGlobally;
  final bool onlyShowUnread;
  final bool showReadingTime;
  final String orderx;


  // final List<Feed> feeds;
  // final bool expanded;

  const Category({
    required this.id,
    required this.title,
    this.userId = 0,
    this.hideGlobally = false,
    this.onlyShowUnread = false,
    this.showReadingTime = false,
    this.orderx = Frc.orderxPublishedAt,
    // this.feeds = const [],
    // this.expanded = false,
  });

  static Category empty = Category(id: 0, title: "",);

  bool get isEmpty {
    return id == 0;
  }

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
    String? orderx,
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
      orderx: orderx ?? this.orderx,
      // feeds: feeds ?? this.feeds,
      // expanded: expanded ?? this.expanded,
    );
  }

}