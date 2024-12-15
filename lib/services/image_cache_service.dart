import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../utils/logger.dart';

class ImageCacheService {
  static final DefaultCacheManager _cacheManager = DefaultCacheManager();
  static const String defaultIconSuffix = '_default';

  // 缓存 base64 图片
  static Future<void> cacheBase64Image(String base64String, String key) async {
    try {
      final cleanBase64 = base64String.split(',').last;
      final imageData = base64Decode(cleanBase64);
      await _cacheManager.putFile(
        key,
        imageData.buffer.asUint8List(),
        fileExtension: 'png',
      );
    } catch (e) {
      logger.e('Error caching image: $e');
    }
  }

  static Future<void> markAsFailed(String key) async {
    try {
      // 存储一个标记文件，表示这个图标加载失败
      await _cacheManager.putFile(
        '$key$defaultIconSuffix',
        Uint8List(0),  // 空数据，仅作为标记
        maxAge: const Duration(days: 30),  // 设置较长的缓存时间
      );
    } catch (e) {
      logger.e('Error marking failed icon: $e');
    }
  }

  static Future<bool> isFailedIcon(String key) async {
    try {
      final failedMark = await _cacheManager.getFileFromCache('$key$defaultIconSuffix');
      return failedMark != null;
    } catch (e) {
      return false;
    }
  }

  static Future<Uint8List?> getCachedImage(String key) async {
    try {
      // 首先检查是否是已知的失败图标
      if (await isFailedIcon(key)) {
        return null;  // 直接返回 null，表示使用默认图标
      }

      final fileInfo = await _cacheManager.getFileFromCache(key);
      if (fileInfo != null) {
        return await fileInfo.file.readAsBytes();
      }
    } catch (e) {
      logger.e('Error getting cached image: $e');
    }
    return null;
  }

  // 清除缓存
  static Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }
}