import 'dart:async';
import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:follow_read/features/presentation/providers/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:http/http.dart' show BaseClient, Client, StreamedResponse, BaseRequest;

import '../../../config/theme.dart';

class FeedIcon extends HookConsumerWidget {

  final String title;
  final String iconUrl;
  final double size;
  final TextStyle textStyle;
  final Color beginBackgroundColor;
  final Color endBackgroundColor;
  final double radius;

  const FeedIcon({
    super.key,
    required this.title,
    required this.iconUrl,
    this.size = 24,
    this.textStyle = const TextStyle(
      fontSize: 15,
      height: 1.33,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    this.beginBackgroundColor = AppTheme.black25, // 50% 透明度 (0x80 = 128)
    this.endBackgroundColor = AppTheme.black75, // 75% 透明度 (0xBF = 191)
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((state) => state.user));
    final cachedImageFuture = useMemoized(() {
      if (iconUrl.isEmpty || user == null) return null;
      return _ImageRequestCache.getImage(
        iconUrl,
        {"X-Auth-Token": user.token},
        Base64IconManager(),
      );
    }, [iconUrl, user?.token]);

    return iconUrl.isNotEmpty == true && user != null
      ? FutureBuilder<Uint8List?>(
        future: cachedImageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: AppTheme.black4,
              highlightColor: AppTheme.black8,
              child: Container(width: size, height: size, color: Colors.white,),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return _buildInitialsAvatar();
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.memory(
              snapshot.data!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high, // 启用高质量过滤
              isAntiAlias: true, //
            ),
          );
        }
    )
     :  _buildInitialsAvatar();
  }


  Widget _buildInitialsAvatar() {
    final initials = _getInitials(title);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            beginBackgroundColor,
            endBackgroundColor,
          ],
        ),
      ),
      child: Text(
        initials,
        style: textStyle,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }

  String _getInitials(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return "?";
    return trimmed[0].toUpperCase();

    // final firstSpaceIndex = trimmed.indexOf(' ');
    // if (firstSpaceIndex != -1 && firstSpaceIndex < trimmed.length - 1) {
    //   return '${trimmed[0]}${trimmed[firstSpaceIndex + 1]}'.toUpperCase();
    // }
    // return trimmed[0].toUpperCase();
  }
}

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
