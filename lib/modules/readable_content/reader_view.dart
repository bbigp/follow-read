import 'package:flutter/material.dart';
import 'package:follow_read/data/services/feed_parser_service.dart';
import 'package:follow_read/global/widgets/loading_more.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class MercuryExtractor extends StatefulWidget {
  final Function(ExtractedContent result)? onResult;
  final String targetUrl;
  const MercuryExtractor({super.key, required this.targetUrl, this.onResult,});

  @override
  State<MercuryExtractor> createState() => _MercuryExtractorState();
}

class _MercuryExtractorState extends State<MercuryExtractor> {
  late final WebViewController _controller;
  final String _channelName = 'channel';
  bool _extractionStarted = false; // 防止重复执行
  final mercury = Get.find<FeedParserService>().mercury;

  final script = '''
    (async function() {
    const result = await Mercury.parse(window.location.href, {html: document.documentElement.outerHTML});
    channel.postMessage(JSON.stringify(result));
    })()
  ''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        _channelName,
        onMessageReceived: (JavaScriptMessage message) {
          final Map<String, dynamic> jsonMap = jsonDecode(message.message);
          widget.onResult?.call(ExtractedContent.fromJson(jsonMap));
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            if (!_extractionStarted) {
              _extractionStarted = true;
              await _controller.runJavaScript(mercury);
              await _controller.runJavaScript(script);
            }
          },
        ),
      );

    _controller.loadRequest(Uri.parse(widget.targetUrl));
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 0, height: 0, child: WebViewWidget(controller: _controller));
  }
}

typedef ExtractedContentCallback = void Function(ExtractedContent result);
class ReaderLoader extends StatefulWidget {
  final String targetUrl;
  final ExtractedContentCallback onComplete;
  const ReaderLoader({super.key, required this.targetUrl, required this.onComplete});

  @override
  State<ReaderLoader> createState() => _ReaderLoaderState();
}

class _ReaderLoaderState extends State<ReaderLoader> {

  void _handleExtractionResult(ExtractedContent extracted) {
    debugPrint("阅读模式: ${widget.targetUrl}");
    if (!mounted) return;
    widget.onComplete(extracted);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MercuryExtractor(
          targetUrl: widget.targetUrl,
          onResult: _handleExtractionResult,
        ),
        const LoadingMore(),
      ],
    );
  }
}


class ExtractedContent {
  final String author;
  final String content;
  final String datePublished;
  final String domain;
  final String excerpt;
  final String leadImageUrl;
  final String title;
  final String url;

  const ExtractedContent({
    this.author = '',
    this.content = '',
    this.datePublished = '',
    this.domain = '',
    this.excerpt = '',
    this.leadImageUrl = '',
    this.title = '',
    this.url = '',
  });

  factory ExtractedContent.fromJson(Map<String, dynamic> json) {
    return ExtractedContent(
      author: (json['author'] as String?) ?? '',
      content: (json['content'] as String?) ?? '',
      datePublished: (json['date_published'] as String?) ?? '',
      domain: (json['domain'] as String?) ?? '',
      excerpt: (json['excerpt'] as String?) ?? '',
      leadImageUrl: (json['lead_image_url'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      url: (json['url'] as String?) ?? '',
    );
  }

  ExtractedContent copyWith({
    String? author,
    String? content,
    String? datePublished,
    String? domain,
    String? excerpt,
    String? leadImageUrl,
    String? title,
    String? url,
  }) {
    return ExtractedContent(
      author: author ?? this.author,
      content: content ?? this.content,
      datePublished: datePublished ?? this.datePublished,
      domain: domain ?? this.domain,
      excerpt: excerpt ?? this.excerpt,
      leadImageUrl: leadImageUrl ?? this.leadImageUrl,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }
}