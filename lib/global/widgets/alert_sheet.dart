

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';

import '../../../global/widgets/buttonx.dart';
import 'cupx_sheet_title.dart';
import '../../../global/widgets/drag_handle.dart';

class AlertSheet extends StatelessWidget {

  final String title;
  final String msg;
  final Future<void> Function()? onPressed;


  const AlertSheet({super.key, required this.title, this.msg = "", this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        const DragHandle(),
        const SizedBox(height: 4,),
        Row(children: [
          SvgPicture.asset(SvgIcons.alert_fill, width: 20, height: 20, fit: BoxFit.none,),
          const SizedBox(width: 12,),
          Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text17500,)),
          const SizedBox(width: 12,),
          const CupxSheetTitleCloseButton(),
        ],),
        const SizedBox(height: 12,),
        if (msg.isNotEmpty) Text(msg, style: AppTextStyles.caption,),
        const SizedBox(height: 24,),
        TextButtonx(child: '确认',
          size: Sizex.large, type: ButtonxType.danger,
          enabled: true, onPressed: onPressed,
        ),
        const SizedBox(height: 24,),
      ],),
    );
  }


}