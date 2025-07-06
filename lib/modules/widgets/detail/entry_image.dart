
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class EntryImage extends StatelessWidget {

  final String url;
  final GestureTapCallback? onTap;
  final double? height;
  const EntryImage({super.key, required this.url, this.onTap, this.height});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const SizedBox.shrink();
    }
    Widget widget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: AppColors.black08),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
            imageUrl: url, height: height, fit: BoxFit.cover, width: double.infinity,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
              child: Container(height: height, color: Colors.white,),
            ),
            errorWidget: (context, url, error) => Container(height: 241,
              color: Colors.grey[300], // 错误时的背景颜色
              child: Icon(Icons.broken_image), // 错误图标
            )
        ),
      ),
    );
    return onTap == null ? widget : GestureDetector(onTap: onTap, child: widget,);
  }

}