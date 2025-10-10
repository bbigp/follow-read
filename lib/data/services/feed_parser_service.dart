
import 'package:follow_read/data/model/feed.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeedParserService extends GetxService{

  // 核心方法：接收 URL，返回解析后的 FeedData
  Future<Feed?> parseFeedUrl(String feedUrl) async {
    final client = http.Client();
    final response = await client.get(Uri.parse(feedUrl));

    if (response.statusCode != 200) {
      throw Exception('网络请求失败，状态码: ${response.statusCode}');
    }

    try {
      // 尝试将响应体解析为 RSS Feed
      final rssFeed = RssFeed.parse(response.body);

      // 如果成功解析为 RSS
      return Feed(
        title: rssFeed.title,
        feedUrl: rssFeed.link,
        desc: rssFeed.description,
      );

    } catch (e) {
      // 如果解析 RSS 失败，尝试解析为 Atom Feed
      try {
        final atomFeed = AtomFeed.parse(response.body);

        // 如果成功解析为 Atom
        return Feed(
          title: atomFeed.title,
          feedUrl: atomFeed.links?.first.href,
        );
      } catch (e2) {
        return null;
      }
    } finally {
      client.close();
    }
  }
}