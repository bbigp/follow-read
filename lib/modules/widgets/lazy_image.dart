
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'no_media.dart';

class LazyImage extends StatefulWidget {
  final String url;
  final double loadThreshold;
  final Duration debounceTime;

  const LazyImage({
    super.key,
    required this.url,
    this.loadThreshold = 0.2,
    this.debounceTime = const Duration(milliseconds: 300),
  });

  @override
  LazyImageState createState() => LazyImageState();
}

class LazyImageState extends State<LazyImage> {
  bool _shouldLoad = false;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: _handleVisibilityChange,
      child: _buildContent(),
    );
  }

  void _handleVisibilityChange(VisibilityInfo info) {
    final isVisible = info.visibleFraction >= widget.loadThreshold;

    if (!mounted) return;

    if (isVisible && !_shouldLoad) {
      setState(() {
        _shouldLoad = true;
      });
    }
  }

  Widget _buildContent() {
    if (!_shouldLoad) {
      return _buildPlaceholder();
    }

    return CachedNetworkImage(
      cacheManager: CustomCacheManager(),
      imageUrl: widget.url,
      httpHeaders: {
        "Referer": getRootDomain(widget.url) ?? "",
      },
      width: 80, height: 80,
      placeholder: (_, __) => _buildPlaceholder(),
      errorWidget: (_, __, ___) => _buildPlaceholder(),
      // imageBuilder: (_, __) => _buildPlaceholder(),
      fit: BoxFit.cover,
    );
  }

  Widget _buildPlaceholder() {
    return NoMedia(width: 80, height: 80,);
  }

  String? getRootDomain(String urlString) {
    return "https://sspai.com";
  }
}

class CustomCacheManager extends CacheManager {
  static const String key = 'customCache';

  CustomCacheManager()
      : super(Config(
    key,
    stalePeriod: Duration(days: 7),
    maxNrOfCacheObjects: 500, // 最大缓存文件数
    repo: JsonCacheInfoRepository(databaseName: key),
    fileService: CustomHttpFileService(),
  ));
}

class CustomHttpFileService extends HttpFileService {
  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) async {
    logger.i('dio request $url');
    return super.get(url, headers: {
      "Referer": "https://sspai.com",
    });
  }
}