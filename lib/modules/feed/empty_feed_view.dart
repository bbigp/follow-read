

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/modules/feed/feed_form.dart';
import 'package:follow_read/modules/widgets/open_modal.dart';

import '../widgets/feed/svg_icon_button.dart';

class EmptyFeedView extends StatelessWidget {

  const EmptyFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 40,),
      Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(SvgIcons.folder, height: 60, width: 82,),
      ),
      const Text('没有订阅源', style: AppTextStyles.hint500,),
      const SizedBox(height: 24,),
      SvgIconButton(label: '添加订阅', onPressed: () async {
        OpenModal.open(context, FeedForm());
      },),
    ]);
  }

}