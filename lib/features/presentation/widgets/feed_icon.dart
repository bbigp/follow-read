

import 'dart:async';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FeedIcon extends StatelessWidget {

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
    this.beginBackgroundColor = const Color(0x80555555), // 50% 透明度 (0x80 = 128)
    this.endBackgroundColor = const Color(0xBF555555), // 75% 透明度 (0xBF = 191)
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: iconUrl.isNotEmpty == true
          ?  _buildCachedNetworkImage()
          :  _buildInitialsAvatar(),
    );
  }

  Widget _buildCachedNetworkImage(){
    return Container(
      width: size,
      height: size,
      color: Colors.transparent,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: CachedNetworkImage(
        imageUrl: iconUrl,
        httpHeaders: {
          "X-Auth-Token": "lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600=",
        },
        imageBuilder: (context, imageProvider) {
          if (imageProvider is MemoryImage) {
            return Image(image: imageProvider);
          }
          return _processResponseToBase64(imageProvider);
        },
        fit: BoxFit.cover,
        width: size,
        height: size,
        progressIndicatorBuilder: (context, url, progress) => _buildInitialsAvatar(),
        errorWidget: (context, url, error) => _buildInitialsAvatar(),
      ),
    );
  }

  Future<ByteData> _loadImageData(ImageProvider provider) async {
    final Completer<ByteData> completer = Completer<ByteData>();
    final ImageStream stream = provider.resolve(ImageConfiguration.empty);

    late final ImageStreamListener listener;
    listener = ImageStreamListener(
            (ImageInfo image, bool sync) async {
          try {
            final ByteData? byteData = await image.image.toByteData();
            if (byteData != null) {
              completer.complete(byteData); // ✅ 类型安全传递
            } else {
              completer.completeError(Exception('图片数据为空'));
            }
          } catch (e) {
            completer.completeError(e);
          } finally {
            stream.removeListener(listener);
          }
        },
        onError: (error, stackTrace) {
          completer.completeError(error, stackTrace);
          stream.removeListener(listener);
        }
    );
    stream.addListener(listener);
    return completer.future;
  }

  Widget _processResponseToBase64(ImageProvider imageProvider) {
    return FutureBuilder<ByteData>(
      future: _loadImageData(imageProvider),
      builder: (context, snapshot) {

        return _buildInitialsAvatar();
      },
    );
  }


  Widget _buildInitialsAvatar(){
    final initials = _getInitials(title);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              beginBackgroundColor,
              endBackgroundColor,
            ]
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Text(
          initials,
          style: textStyle,
        ),
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