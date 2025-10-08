

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/element_type.dart';

import 'buttonx.dart';
import 'cupx_sheet_title.dart';
import 'drag_handle.dart';
import 'pg_text.dart';

///
class ConfirmSheet extends StatelessWidget {

  final String title;
  final String msg;
  final Future<void> Function()? onPressed;
  final ElementType? type;


  const ConfirmSheet({super.key, required this.title, this.msg = "",
    this.onPressed,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    ConfirmSheetStyle style = switch(type) {
      ElementType.danger => ConfirmSheetStyle(iconColor: AppColors.red00, buttonxType: ElementType.danger),
      _ => ConfirmSheetStyle(iconColor: AppColors.red00, buttonxType: ElementType.danger),
    };
    return Padding(padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        const DragHandle(),
        Padding(padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(children: [
            SvgPicture.asset(
                SvgIcons.alert_fill, width: 20, height: 20, fit: BoxFit.none,
              colorFilter: ColorFilter.mode(style.iconColor, BlendMode.srcIn,)
            ),
            const SizedBox(width: 12,),
            Expanded(child: PgText(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M17,)),
            const SizedBox(width: 12,),
            const CupxSheetTitleCloseButton(),
          ],),
        ),
        if (msg.isNotEmpty) PgText(msg, style: AppTextStyles.R15B50,),
        Padding(padding: EdgeInsets.symmetric(vertical: 24),
          child: TextButtonx(child: '确认', size: Sizex.medium, type: style.buttonxType,
            enabled: true, onPressed: onPressed,
          ),
        ),
      ],),
    );
  }
}

class ConfirmSheetStyle {
  final Color iconColor;
  final ElementType buttonxType;
  const ConfirmSheetStyle({
    required this.iconColor,
    required this.buttonxType,
  });
}