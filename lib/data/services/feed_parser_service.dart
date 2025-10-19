
import 'package:flutter/services.dart' show rootBundle;
import 'package:follow_read/data/model/feed.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class FeedParserService extends GetxService{

  var mercury = "";

  @override
  void onReady() {
    super.onReady();
    loadParserJsCode();
  }

  Future<void> loadParserJsCode() async {
    mercury = await rootBundle.loadString('assets/mercury.web.js');
  }

  // 核心方法：接收 URL，返回解析后的 FeedData
  Future<Feed?> parseFeedUrl(String feedUrl) async {
    final client = http.Client();
    final response = await client.get(Uri.parse(feedUrl));

    if (response.statusCode != 200) {
      return null;
    }

    try {
      final document = XmlDocument.parse(response.body);
      if (document.findAllElements('rss').isNotEmpty) {
        return _parseRss(document).copyWith(feedUrl: feedUrl);
      } else if (document.findAllElements('feed').isNotEmpty) {
        return _parseAtom(document).copyWith(feedUrl: feedUrl);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }


  Feed _parseRss(XmlDocument document) {
    final channel = document.findAllElements('channel').first;

    // RSS 字段名：<title>, <link>, <description>
    return Feed(
      title: channel.findElements('title').first.innerText,
      siteUrl:  channel.findElements('link').first.innerText,
      desc: channel.findElements('description').firstOrNull?.innerText ?? "",
    );
  }


  Feed _parseAtom(XmlDocument document) {
    final feed = document.findAllElements('feed').first;

    // Atom 字段名：<title>, <link>, <subtitle> (相当于 description)

    // Atom 的 link 是属性 <link href="URL"/>，需要查找主链接
    final linkElement = feed.findAllElements('link').firstWhere(
            (e) => e.getAttribute('rel') == 'alternate' || e.getAttribute('rel') == null,
        orElse: () => feed.findAllElements('link').first);

    // Atom 使用 <subtitle> 作为 Feed 的描述
    final descriptionElement = feed.findElements('subtitle').firstOrNull;

    return Feed(
      title: feed.findElements('title').first.innerText,
      siteUrl: linkElement.getAttribute('href') ?? linkElement.innerText,
      desc: descriptionElement?.innerText ?? "",
    );
  }




}