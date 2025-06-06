import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:http/http.dart' show BaseClient, Client, StreamedResponse, BaseRequest;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// 自定义缓存管理器（控制缓存策略）
class Base64IconManager extends CacheManager {
  static const key = 'base64IconCache';

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
  late Future<Uint8List?> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _ImageRequestCache.getImage(
      widget.imageUrl,
      widget.headers,
      widget.cacheManager ?? Base64IconManager(),
    );
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

// 全局请求缓存（内存级）
class _ImageRequestCache {
  static final Map<String, Future<Uint8List?>> _pendingRequests = {};
  static final Map<String, Uint8List> _memoryCache = {};

  static Future<Uint8List?> getImage(
      String url,
      Map<String, String> headers,
      BaseCacheManager cacheManager,
      ) async {
    final cacheKey = _normalizeUrl(url);

    // 1. 检查内存缓存
    if (_memoryCache.containsKey(cacheKey)) {
      return _memoryCache[cacheKey];
    }

    // 2. 检查正在进行的请求
    if (_pendingRequests.containsKey(cacheKey)) {
      return _pendingRequests[cacheKey];
    }

    // 3. 创建新请求
    final completer = Completer<Uint8List?>();
    _pendingRequests[cacheKey] = completer.future;

    try {
      // 4. 实际下载逻辑
      final bytes = await _downloadAndCache(url, headers, cacheManager);
      _memoryCache[cacheKey] = bytes; // 写入内存缓存
      completer.complete(bytes);
    } catch (e) {
      completer.completeError(e);
    } finally {
      _pendingRequests.remove(cacheKey);
    }

    return completer.future;
  }

  static String _normalizeUrl(String url) {
    // 标准化URL格式（去除查询参数）
    final uri = Uri.parse(url);
    return Uri(
      scheme: uri.scheme,
      host: uri.host,
      path: uri.path,
    ).toString();
  }

  static Future<Uint8List> _downloadAndCache(
      String url, Map<String, String> headers, BaseCacheManager cache) async {
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
      final jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
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
}