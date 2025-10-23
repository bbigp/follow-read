

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/element_type.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

import 'entry_content.dart';
import 'entry_file.dart';
import 'entry_image.dart';
import 'entry_video.dart';
import 'entry_web.dart';

class EntryView extends StatelessWidget {

  final Entry entry;
  const EntryView({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20,),

      if (entry.pic.isNotEmpty) ...[
        Padding(padding: EdgeInsets.symmetric(horizontal: 16),
          child: EntryImage(url: entry.pic, height: 241, width: double.infinity, onTap: (){
            // ref.read(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
            //   "imageUrls": entry.allImageUrls, "index": entry.allImageUrls.indexOf(entry.pic),
            // });
          },),
        ),
        const SizedBox(height: 12,),
      ],

      Padding(padding: EdgeInsets.symmetric(horizontal: 16),
        child: EntryTitle(entry: entry),
      ),
      const SizedBox(height: 12,),

      // if (entry.medias.isNotEmpty) ...[
      //   Wrap(
      //     children: entry.medias.map((media) {
      //       if (entry.pic == media.url) {
      //         return const SizedBox.shrink();
      //       }
      //       if (media.isVideo) {
      //         return EntryVideo(url: media.url);
      //       }
      //
      //       if (media.isImage) {
      //         return Align(
      //           alignment: Alignment.topLeft,
      //           child: EntryImage(url: media.url, boxFit: BoxFit.scaleDown, alignment: Alignment.topLeft,),
      //         );
      //       }
      //       return EntryFile(url: media.url);
      //     }).toList(),
      //   ),
      //   const SizedBox(height: 12,),
      // ],

      EntryRead(entry: entry),
      // EntryContent(entry: entry),
      const SizedBox(height: 12,),

      const NoMore(),
      const SizedBox(height: 12,),

      const SizedBox(height: 8,),
      IconButtonx(
        child: "View Website", icon: SvgIcons.out_o,
        isLeftIcon: false,
        size: Sizex.custom,
        buttonSize: mediumCompact().copyWith(padding: 32,),
        type: ElementType.secondary,
        enabled: true,
        onPressed: () => Open.browser(entry.url),
      ),
      const SizedBox(height: 8,),
      const SizedBox(height: 48,),

      const SizedBox(height: 48,),

      const SizedBox(height: 36,)//底部导航
    ],);
  }

}

class EntryTitle extends StatelessWidget {

  final Entry entry;
  const EntryTitle({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8,),
      PgText(entry.title, maxLines: 10, style: AppTextStyles.M22,),
      const SizedBox(height: 8,),
      EntryAuthor(entry: entry),
      const SizedBox(height: 8,),
      PgText(entry.publishedAt.toString(), maxLines: 1, style: AppTextStyles.M11B50),
      const SizedBox(height: 8,),
    ],);
  }

}

class EntryAuthor extends StatelessWidget {

  final Entry entry;
  const EntryAuthor({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double totalRowWidth = constraints.maxWidth;
      const double fixedWidth = 17.0;
      double authorWidth = 0.0;
      if (entry.author.isNotEmpty) {
        // 使用一个辅助组件来测量 author 的最小宽度
        // 注意：这种测量方式可能会稍微影响性能，但可以解决 PgText 的 maxWidth 依赖。
        authorWidth = _calculatePgTextWidth(
          entry.author,
          AppTextStyles.M11B50,
          maxLines: 2,
          maxWidth: totalRowWidth / 2, // 限制它最多占 Row 总宽度的一半 (防止溢出)
        );

        // 加上分隔符的固定宽度
        authorWidth += fixedWidth;
      }
      final double remainingWidth = totalRowWidth - authorWidth;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (entry.author.isNotEmpty) ...[
            PgText(entry.author, maxLines: 2, style: AppTextStyles.M11B50, maxWidth: authorWidth,),
            const SizedBox(width: 8),
            Container(width: 1, height: 6, color: AppColors.black08),
            const SizedBox(width: 8),
          ],
          Expanded(child: PgText(entry.feed.title, maxLines: 2, style: AppTextStyles.M11B50,)),
        ],
      );
    });
  }

  double _calculatePgTextWidth(String text, TextStyle style, {int maxLines = 1, double maxWidth = double.infinity}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr, // 假设从左到右
    )..layout(minWidth: 0, maxWidth: maxWidth); // 限制最大宽度

    // 返回理想的最小宽度（如果只有一行）或被 maxWidth 限制后的宽度
    return textPainter.width;
  }
}