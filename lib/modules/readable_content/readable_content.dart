import 'package:flutter/material.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'dart:async';

// 定义解析结果的结构
class ArticleResult {
  final String title;
  final String contentHtml;

  ArticleResult({required this.title, required this.contentHtml});
}

class ArticleExtractor extends StatefulWidget {
  // 1. 回调函数：用于接收解析后的结果
  final Function(String result)? onResult;

  final String targetUrl;

  const ArticleExtractor({
    super.key,
    required this.targetUrl, // <--- 关键修改
    this.onResult,
  });

  @override
  State<ArticleExtractor> createState() => _ArticleExtractorState();
}

class _ArticleExtractorState extends State<ArticleExtractor> {
  late final WebViewController _controller;
  final String _channelName = 'ConsoleLogChannel';
  bool _extractionStarted = false; // 防止重复执行
  final parserJsCode = Get.find<HomeController>().jsCode;

  final jsExecutionCode = '''
    (async function() {
    const result = await Mercury.parse(window.location.href, {html: document.documentElement.outerHTML});
    ConsoleLogChannel.postMessage(JSON.stringify(result));
    })()
  ''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
    ..addJavaScriptChannel(
      _channelName,
      onMessageReceived: (JavaScriptMessage message) {
        debugPrint(message.message);
        widget.onResult?.call(message.message);
      },
    )
      ..setNavigationDelegate(
        NavigationDelegate(
          // 页面加载完成后，注入解析器并启动解析
          onPageFinished: (String url) async {
            // 确保只运行一次
            if (!_extractionStarted) {
              _extractionStarted = true;
              debugPrint(parserJsCode);
              await _controller.runJavaScript(parserJsCode);
              await _controller
                  .runJavaScript(jsExecutionCode);
            }
          },
        ),
      );

    _controller.loadRequest(Uri.parse(widget.targetUrl));
  }


  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ArticleResult? _article;

  final String _targetUrl = 'https://sspai.com/prime/story/inside-release-notes-251016';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('内容提取测试')),
      body: Stack(
        children: [
          // 1. 在后台运行 ArticleExtractor
          ArticleExtractor(
            targetUrl: _targetUrl,
            onResult: (result) {
              setState(() {

              });
            },
          ),
        ],
      ),
    );
  }
}