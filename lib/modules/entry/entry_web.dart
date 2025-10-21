

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/services/feed_parser_service.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EntryRead extends StatefulWidget {
  final Entry entry;
  const EntryRead({super.key, required this.entry});

  @override
  State<EntryRead> createState() => _LocalWebViewState();
}

class _LocalWebViewState extends State<EntryRead> {

  InAppWebViewController? _controller;
  final cssContent = Get.find<FeedParserService>().cssContent;
  final String _localBaseUrl =
  Platform.isAndroid
      ? 'file:///android_asset/flutter_assets/assets/html/'
      : 'file://${Directory.current.path}/assets/html/';

  Future<void> _loadContent(InAppWebViewController controller) async {
    String finalHtml = '''
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          $cssContent
        </style>
      </head>
      ${widget.entry.readableContent}
    </html>
    ''';

    controller.loadData(
      baseUrl: WebUri(_localBaseUrl),
      data: finalHtml,
      mimeType: 'text/html',
      encoding: 'utf-8',
    );
  }



  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('about:blank')),
      onWebViewCreated: (controller) {
        _loadContent(controller);
      },
      initialSettings: InAppWebViewSettings(
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
      ),
      onLoadError: (controller, url, code, message) {
        print('WebView 加载错误: $message');
      },
    );
    //return WebViewWidget(controller: _controller);
  }

}