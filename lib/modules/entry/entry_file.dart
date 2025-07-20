


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

class EntryFile extends StatelessWidget {

  final String url;
  const EntryFile({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    Widget view = CardView(
      borderRadius: 12,
      padding: EdgeInsets.all(16),
      border: Border.all(color: AppColors.black08, width: 0.5),
      child: Row(children: [
        SizedBox(width: 20, height: 20, child: SvgPicture.asset(SvgIcons.file, width: 20, height: 20, fit: BoxFit.contain,),),
        const SizedBox(width: 8,),
        const SizedBox(width: 4,),
        Expanded(child: PgText(getFileNameFromUrl(url), style: AppTextStyles.R15)),
        const SizedBox(width: 4,),
      ],)
    );
    return Column(children: [
      const SizedBox(height: 8,),
      InkWell(child: view, onTap: () => Open.browser(url),),
      const SizedBox(height: 8,),
    ],);
  }

  String getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path; // /codrops/wp-content/uploads/2025/06/video-13.mp4
    return path.split('/').last; // video-13.mp4
  }
}