

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/services/feed_parser_service.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReaderTheme {
  final String fontSize;
  final String fontFamily;
  final String backgroundColor;

  const ReaderTheme({
    this.fontSize = "16px", this.fontFamily = "'DM Sans'",  //DM Mono
    this.backgroundColor = "#fff",
  });

}

class EntryRead extends StatefulWidget {
  final Entry entry;
  const EntryRead({super.key, required this.entry});

  @override
  State<EntryRead> createState() => _LocalWebViewState();
}

class _LocalWebViewState extends State<EntryRead> {

  InAppWebViewController? _controller;

  final mainCss = Get.find<FeedParserService>().mainCss;
  final String _localBaseUrl = Platform.isAndroid
      ? 'file:///android_asset/flutter_assets/assets/'
      : 'file://${Directory.current.path}/assets/';

  Future<void> _loadContent() async {
    var theme = ReaderTheme();
    var css = mainCss.replaceAll("FF_FONT_FAMILY", theme.fontFamily)
      .replaceAll("FF_FONT_SIZE", theme.fontSize)
      .replaceAll("FF_BACKGROUND_COLOR", theme.backgroundColor);

    String finalHtml = '''
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"">
        <title>${widget.entry.title}</title>
        <style>
        $css
        </style>
      </head>
      <body>
        <div id="br-article" class="active">
          <div class="br-content">${widget.entry.readableContent}</div>
        </div>
      </body>    
    </html>
    ''';

    await _controller?.loadData(baseUrl: WebUri(_localBaseUrl), data: finalHtml,
      mimeType: 'text/html', encoding: 'utf-8',
    );
  }

  @override
  void initState() {
    super.initState();
    debugPrint(widget.entry.title);
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(_localBaseUrl)),
      onWebViewCreated: (controller) {
        _controller = controller;
        _loadContent();
      },
      onLoadStart: (controller, url) {

      },
      onLoadStop: (controller, url) async {
        // controller.injectCSSCode(source: source)
        // await controller.injectCSSFileFromAsset(
        //     assetFilePath: 'assets/html/main.css'
        // );
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

  @override
  void dispose() {
    super.dispose();
  }

}