import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:http/http.dart' show BaseClient, Client, StreamedResponse, BaseRequest;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// 自定义缓存管理器（控制缓存策略）
class Base64IconManager extends CacheManager {
  static const key = 'base64IconCanche';

  Base64IconManager()
      : super(Config(key,
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
    repo: JsonCacheInfoRepository(databaseName: key),
  ));
}

class _AuthenticatedHttpClient extends BaseClient {
  final Client _inner = Client();
  final Map<String, String> headers;

  _AuthenticatedHttpClient(this.headers);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);
    return _inner.send(request);
  }
}

class Base64Icon extends StatefulWidget {
  final String imageUrl;
  final Map<String, String> headers;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BaseCacheManager? cacheManager;

  const Base64Icon({
    super.key,
    required this.imageUrl,
    required this.headers,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.cacheManager,
  });

  @override
  Base64IconState createState() => Base64IconState();
}

class Base64IconState  extends State<Base64Icon> {
  final AsyncMemoizer<Uint8List?> _memoizer = AsyncMemoizer();
  late Future<Uint8List?> _imageFuture;

 @override
  void initState() {
    super.initState();
    _imageFuture = _memoizer.runOnce(() => _getImageBytes(widget.imageUrl, widget.headers));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
        future: _imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return widget.placeholder ?? _defaultPlaceholder();
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return widget.errorWidget ?? _defaultErrorWidget();
          }
          return Image.memory(
            snapshot.data!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            filterQuality: FilterQuality.high, // 启用高质量过滤
            isAntiAlias: true, //
          );
        }
    );
  }


  Future<Uint8List?> _getImageBytes(String url, Map<String, String> headers) async {
    final cache = widget.cacheManager ?? Base64IconManager();
    final cacheKey = url.toString();
    try {
      final cachedFile = await cache.getFileFromCache(cacheKey);
      if (cachedFile != null && cachedFile.file.existsSync()) {
        final bytes = await cachedFile.file.readAsBytes();
        if (bytes.isEmpty) {
          throw Exception('Cached error marker');
        }
        return bytes;
      }
      final client = _AuthenticatedHttpClient(headers);
      final response = await client.get(Uri.parse(url));
      logger.i('下载icon$url}');
      if (response.statusCode != 200) {
        await cache.putFile(
          cacheKey,
          Uint8List(0),
        );
        throw Exception('HTTP ${response.statusCode}');
      }
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final base64WithHeader = jsonData['data'] as String;
      final parts = base64WithHeader.split(';base64,');
      if (parts.length != 2) {
        throw FormatException('无效的 Base64 数据格式');
      }
      final bytes = base64.decode(parts[1]);
      await cache.putFile(cacheKey, bytes, fileExtension: 'dat');
      return bytes;
    } catch (e) {
      throw Exception('图片加载失败: $e');
    }
  }

  Widget _defaultPlaceholder(){
    return Container(
      color: Colors.grey[200],
      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
  Widget _defaultErrorWidget(){
    return Container(
      color: Colors.grey[200],
      child: Center(child: Icon(Icons.broken_image, color: Colors.grey)),
    );
  }

}