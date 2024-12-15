import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

import '../services/api.dart';
import '../services/image_cache_service.dart';

class FeedIconView extends StatefulWidget {
  final int iconId;

  const FeedIconView({
    super.key,
    required this.iconId,
  });

  @override
  State<FeedIconView> createState() => _FeedIconViewState();
}

class _FeedIconViewState extends State<FeedIconView> {
  bool isLoading = true;
  Uint8List? imageData;
  String? error;

  // 添加缓存键

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (!mounted) return;
    final iconKey = 'feed_icon_${widget.iconId}';
    if (await ImageCacheService.isFailedIcon(iconKey)) {
      setState(() {
        isLoading = false;
        error = 'Known failed icon';  // 使用默认图标
      });
      return;
    }
    final cachedImage = await ImageCacheService.getCachedImage(iconKey);
    if (cachedImage != null) {
      setState(() {
        imageData = cachedImage;
        isLoading = false;
      });
      return;
    }
    Api.getFeedIcon(
        iconId: widget.iconId,
        onSuccess: (icon) async {
          if (!mounted) return;
          final cleanBase64 = icon.data.split(',').last;
          final newImageData = base64Decode(cleanBase64);

          await ImageCacheService.cacheBase64Image(
            icon.data,
            'feed_icon_${widget.iconId}',
          );
          setState(() {
            imageData = newImageData;
            isLoading = false;
          });
        },
        onError: (error) async {
          if (!mounted) return;
          await ImageCacheService.markAsFailed('feed_icon_${widget.iconId}');
          setState(() {
            this.error = error;
            isLoading = false;
          });
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 加载中显示 shimmer 效果
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      );
    }

    // 发生错误或数据为空时显示默认图标
    if (error != null || imageData == null) {
      return const Icon(
        Icons.rss_feed,
        size: 24,
        color: Color(0xFF8B0000),
      );
    }

    // 显示图片
    return Image.memory(
      imageData!,
      width: 24,
      height: 24,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image render error: $error');
        return const Icon(
          Icons.rss_feed,
          size: 24,
          color: Color(0xFF8B0000),
        );
      },
    );
  }
}
