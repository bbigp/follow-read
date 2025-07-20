
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:shimmer/shimmer.dart';

// class EntryImage extends StatelessWidget {
//   final String url;
//   final GestureTapCallback? onTap;
//   final double? height;
//   final double? width;
//   final String alt;
//   final BoxFit boxFit;
//   final Alignment alignment;
//   final double minVisibleWidth;
//   final double minVisibleHeight;
//
//   const EntryImage({
//     super.key,
//     required this.url,
//     this.onTap,
//     this.height,
//     this.width,
//     this.alt = "",
//     this.boxFit = BoxFit.cover,
//     this.alignment = Alignment.center,
//     this.minVisibleWidth = 20,   // ⬅️ 可自定义阈值
//     this.minVisibleHeight = 20,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (url.isEmpty) return const SizedBox.shrink();
//
//     return FutureBuilder<Size>(
//       future: _getImageSize(url),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState != ConnectionState.done) {
//           return const SizedBox.shrink(); // 或者 loading 占位
//         }
//
//         final size = snapshot.data;
//         if (size == null ||
//             size.width < minVisibleWidth ||
//             size.height < minVisibleHeight) {
//           return const SizedBox.shrink(); // ⬅️ 图片尺寸太小，不显示
//         }
//
//         // 显示正常图片
//         Widget image = Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(width: 0.5, color: AppColors.black08),
//           ),
//           height: height,
//           width: width,
//           clipBehavior: Clip.antiAlias,
//           child: CachedNetworkImage(
//             imageUrl: url,
//             fit: boxFit,
//             alignment: alignment,
//             placeholder: (context, url) => Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(color: Colors.white, height: 100),
//             ),
//             errorWidget: (context, url, error) => Container(
//               height: 100,
//               color: Colors.grey[300],
//               child: const Icon(Icons.broken_image),
//             ),
//           ),
//         );
//
//         Widget widget = Column(
//           children: [
//             const SizedBox(height: 8),
//             image,
//             if (alt.isNotEmpty) ...[
//               const SizedBox(height: 12),
//               PgText(alt, maxLines: 10, style: AppTextStyles.M11B25),
//             ],
//             const SizedBox(height: 8),
//           ],
//         );
//
//         return onTap == null ? widget : GestureDetector(onTap: onTap, child: widget);
//       },
//     );
//   }
//
//   Future<Size> _getImageSize(String url) async {
//     final completer = Completer<Size>();
//     final image = CachedNetworkImageProvider(url);
//
//     final stream = image.resolve(const ImageConfiguration());
//     final listener = ImageStreamListener((ImageInfo info, bool _) {
//       final mySize = Size(
//         info.image.width.toDouble(),
//         info.image.height.toDouble(),
//       );
//       completer.complete(mySize);
//     }, onError: (error, stackTrace) {
//       completer.complete(Size.zero); // 图片加载失败也返回
//     });
//
//     stream.addListener(listener);
//     return completer.future;
//   }
// }


class EntryImage extends StatelessWidget {

  final String url;
  final GestureTapCallback? onTap;
  final double? height;
  final double? width;
  final String alt;
  final BoxFit boxFit;
  final Alignment alignment;
  const EntryImage({super.key, required this.url, this.onTap, this.height, this.width,
    this.alt = "", this.boxFit = BoxFit.cover, this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const SizedBox.shrink();
    }
    Widget image = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.5, color: AppColors.black08),
      ),
      height: height, width: width,
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
          imageUrl: url, fit: boxFit,
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
        const SizedBox(height: 12,),
        PgText(alt, maxLines: 10, style: AppTextStyles.M11B25),
      ],
      const SizedBox(height: 8,),
    ],);
    return onTap == null ? widget : GestureDetector(onTap: onTap, child: widget,);
  }

}