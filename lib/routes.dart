import 'package:flutter/material.dart';
import 'package:follow_read/pages/entries_page.dart';
import 'package:follow_read/pages/home.dart';

import 'models/feed.dart';

class AppRoutes {
  static const String feedList = '/feeds';
  static const String entryList = "/entries";

  static Map<String, WidgetBuilder> routes = {
    feedList: (context) => const MyHomePage(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.feedList:
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
        );
        // final item = settings.arguments as Feed;
        // return MaterialPageRoute(
        //   builder: (context) => MyHomePage(item: item),
        // );
      case AppRoutes.entryList:
        final feed = settings.arguments as Feed;
        return MaterialPageRoute(builder: (context) => EntryListPage(feed: feed));
      default:
        return MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        );
    }
  }

  static Future<T?> navigateTo<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }


}