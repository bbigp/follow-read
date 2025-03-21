import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show BaseClient, Client, StreamedResponse, BaseRequest;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:collection/collection.dart';

// 自定义缓存管理器（控制缓存策略）
class CustomCacheManager extends CacheManager {
  static const key = 'customImageCache';

  CustomCacheManager()
      : super(Config(
    key,
    stalePeriod: const Duration(days: 7),    // 缓存有效期7天
    maxNrOfCacheObjects: 100,                // 最大缓存数量
    repo: JsonCacheInfoRepository(databaseName: key),
  ));
}

class CustomNetworkImage extends ImageProvider<CustomNetworkImage> {
  final String url;
  final Map<String, String> headers;
  final BaseCacheManager cacheManager;
  final double scale;

  const CustomNetworkImage({
    required this.url,
    required this.headers,
    this.cacheManager = CustomCacheManager(),
    this.scale = 1.0, // 默认缩放比例
  });

  @override
  Future<CustomNetworkImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CustomNetworkImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(
      CustomNetworkImage key,
      ImageDecoderCallback decode,
      ) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: key.scale,
      debugLabel: key.url,
      informationCollector: () => [
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<CustomNetworkImage>('Image key', key),
      ],
    );
  }

  Future<ui.Codec> _loadAsync(CustomNetworkImage key) async {
    try {
      // 1. 尝试从缓存获取
      final cacheFile = await key.cacheManager.getFileFromCache(key.url);
      if (cacheFile != null && cacheFile.file.existsSync()) {
        final bytes = await cacheFile.file.readAsBytes();
        return await ui.instantiateImageCodec(Uint8List.fromList(bytes));
      }

      // 2. 缓存未命中，处理实际加载
      Uint8List bytes;

      if (key.url.startsWith('data:image')) { // Base64 数据 URI
        final data = Uri.parse(key.url).data;
        if (data == null) throw Exception('无效的 Base64 URI');
        bytes = data.contentAsBytes();
      } else { // 网络请求
        final client = _AuthenticatedHttpClient(key.headers);
        final response = await client.get(Uri.parse(key.url));
        if (response.statusCode != 200) throw Exception('HTTP ${response.statusCode}');

        final body = utf8.decode(response.bodyBytes);
        if (body.startsWith('data:image')) { // API 返回 Base64
          final data = Uri.parse(body).data;
          bytes = data?.contentAsBytes() ?? Uint8List(0);
        } else { // 二进制图片流
          bytes = response.bodyBytes;
        }

        // 3. 写入缓存（排除 Base64 URI 直接加载的情况）
        if (!key.url.startsWith('data:image')) {
          await key.cacheManager.putFile(
            key.url,
            bytes,
            // headers: key.headers,
          );
        }
      }

      if (bytes.isEmpty) throw Exception('空图片数据');
      return await ui.instantiateImageCodec(bytes);
    } catch (e) {
      throw Exception('图片加载失败: ${e.toString()}');
    }
  }

  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) ||
  //       other is CustomNetworkImage &&
  //           runtimeType == other.runtimeType &&
  //           url == other.url;
  // }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CustomNetworkImage &&
            runtimeType == other.runtimeType &&
            url == other.url); // ✅ 仅比较 url
  }

  // @override
  // int get hashCode => Object.hash(url);

  @override
  int get hashCode => url.hashCode;
}

// 带请求头的 HTTP 客户端
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

// 封装组件（带缓存控制）
class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final Map<String, String> headers;
  final double? width;
  final double? height;
  final BaseCacheManager? cacheManager;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    required this.headers,
    this.width,
    this.height,
    this.cacheManager,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: CustomNetworkImage(
        url: imageUrl,
        headers: headers,
        cacheManager: cacheManager ?? CustomCacheManager(),
      ),
      width: width,
      height: height,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: frame != null ? child : _buildLoading(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildLoading() {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
  }
}

// 使用示例
class ExampleUsage extends StatelessWidget {
  final cacheManager = CustomCacheManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 内嵌 Base64（不缓存）
        const CustomCachedImage(
          imageUrl: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA...',
          headers: {},
          width: 100,
        ),

        // 网络图片（带缓存）
        CustomCachedImage(
          imageUrl: 'https://api.example.com/image/1',
          headers: {'Authorization': 'Bearer token'},
          cacheManager: cacheManager,
          width: 200,
        ),

        // 清空缓存按钮
        TextButton(
          onPressed: () => cacheManager.emptyCache(),
          child: const Text('清空缓存'),
        )
      ],
    );
  }
}