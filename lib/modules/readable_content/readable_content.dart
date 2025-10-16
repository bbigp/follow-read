import 'package:flutter/material.dart';
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

  // 2. 解析器 JS 脚本内容
  // 您需要将 Mercury 或 Readability 的代码作为字符串传入
  final String parserJsCode;

  final String targetUrl;

  const ArticleExtractor({
    super.key,
    required this.targetUrl, // <--- 关键修改
    required this.parserJsCode,
    this.onResult,
  });

  @override
  State<ArticleExtractor> createState() => _ArticleExtractorState();
}

class _ArticleExtractorState extends State<ArticleExtractor> {
  late final WebViewController _controller;
  final String _channelName = 'DartArticleChannel';
  bool _extractionStarted = false; // 防止重复执行

  final jsExecutionCode = '''
    (async function() {
      return await Mercury.parse(window.location.href, {html: document.documentElement.outerHTML});
    })()
  ''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
    // ..addJavaScriptChannel(
    //   _channelName,
    //   onMessageReceived: (JavaScriptMessage message) {
    //     _handleJsResult(message.message);
    //   },
    // )
      ..setNavigationDelegate(
        NavigationDelegate(
          // 页面加载完成后，注入解析器并启动解析
          onPageFinished: (String url) async {
            // 确保只运行一次
            if (!_extractionStarted) {
              _extractionStarted = true;
              await _controller.runJavaScript(widget.parserJsCode);
              final jsonStringResult = await _controller
                  .runJavaScriptReturningResult(jsExecutionCode);
              final String resultString = jsonStringResult is String
                  ? jsonStringResult
                  : jsonStringResult.toString();
              widget.onResult?.call(resultString);
            }
          },
        ),
      );

    _controller.loadRequest(Uri.parse(widget.targetUrl));
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0,
      height: 0,
      child: WebViewWidget(controller: _controller),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ArticleResult? _article;

  // ⚠️ 实际项目中，你需要从 assets/ 或文件中加载这些字符串
  final String _mercuryScript = '''
    // ... 在这里放入您提供的 Mercury 或 Readability 的全部 JS 代码 ...
    // ... 并在最后加上上面的 extractArticle(htmlString) 代理函数 ...
  ''';

  // 待解析的示例 HTML (通常是从网络获取的)
  final String _targetUrl = 'https://some-website.com/article/123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('内容提取测试')),
      body: Stack(
        children: [
          // 1. 在后台运行 ArticleExtractor
          ArticleExtractor(
            targetUrl: _targetUrl,
            parserJsCode: _mercuryScript,
            onResult: (result) {
              setState(() {

              });
            },
          ),

          // 2. 显示结果
          if (_article != null)
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('提取标题: ${_article!.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Divider(),
                  // ⚠️ 注意：如果 contentHtml 包含样式，您可能需要使用 flutter_html 或 webview 来渲染它。
                  Text('提取内容 (HTML): ${_article!.contentHtml}'),
                ],
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}