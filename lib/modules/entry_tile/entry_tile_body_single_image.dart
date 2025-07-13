

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/modules/widgets/lazy_image.dart';

///
class EntryTileBodySingleImage extends ConsumerWidget {

  final Entry entry;
  const EntryTileBodySingleImage({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Column(children: [
        Text(entry.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.M15,),
        // const SizedBox(height: 4,),
        // Row(children: [
        //   SvgPicture.asset(Svgicons.time, width: 14, height: 14, fit: BoxFit.contain, colorFilter: ColorFilter.mode(
        //       AppTheme.black50, BlendMode.srcIn,
        //   ),),
        //   const SizedBox(width: 4,),
        //   Text('${entry.readingTime}', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.caption13500,),
        // ],),
        const SizedBox(height: 4,),
        Visibility(visible: entry.summary.isNotEmpty,
            child: Text(entry.summary, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.R13B50,)
        ),
      ],)),
      const SizedBox(width: 12,),
      GestureDetector(onTap: (){
        // ref.watch(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
        //   "imageUrls": entry.allImageUrls,
        //   "index": 0,
        // });
      }, child: Container(
        width: 80, height: 80, clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.black08, width: 0.5),
        ),
        child: LazyImage(url: entry.pic,),
      ),)
    ],);
  }


}