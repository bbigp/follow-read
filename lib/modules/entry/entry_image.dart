
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:shimmer/shimmer.dart';

///
class EntryImage extends StatelessWidget {

  final String url;
  final GestureTapCallback? onTap;
  final double? height;
  final double? width;
  final String alt;
  final BoxFit boxFit;
  final Alignment alignment;
  final String referer;
  const EntryImage({super.key, required this.url, this.onTap, this.height, this.width,
    this.alt = "", this.boxFit = BoxFit.cover, this.alignment = Alignment.center,
    this.referer = "",
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const SizedBox.shrink();
    }
    Widget image = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 0.5, color: AppColors.black08),
      ),
      height: height, width: width,
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
          imageUrl: url, fit: boxFit,
          httpHeaders: {
            "Referer": referer,
          },
          alignment: alignment,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
            child: Container(color: Colors.white, height: 100,),
          ),
          errorWidget: (context, url, error) => Container(
            height: 100,
            color: Colors.grey[300], // 错误时的背景颜色
            child: Icon(Icons.broken_image), // 错误图标
          )
      )
    );
    Widget widget = Column(children: [
      const SizedBox(height: 8,),
      image,
      if (alt.isNotEmpty) ...[
        const SizedBox(height: 8,),
        PgText(alt, maxLines: 10, style: AppTextStyles.M11B25),
      ],
      const SizedBox(height: 16,),
    ],);
    return onTap == null ? widget : GestureDetector(onTap: onTap, child: widget,);
  }

}