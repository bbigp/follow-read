
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/components/buttonx.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/theme/text_styles.dart';

///
enum AlertViewType { normal, danger, }
class AlertView extends StatelessWidget {

  final String icon;
  final String title;
  final AlertViewType type;
  final String? action;
  final String? actionIcon;

  const AlertView({super.key,
    required this.icon,
    required this.title,
    this.actionIcon,
    this.type = AlertViewType.danger,
    this.action,
  });

  //实现的是一行中号   没有action是小号   2行是2号
  @override
  Widget build(BuildContext context) {
    Color iconColor = type == AlertViewType.danger ? AppTheme.red : AppTheme.blue;
    Color backgroundColor = type == AlertViewType.danger ? AppTheme.red10 : AppTheme.blue10;
    return Container(
      padding: EdgeInsets.all(4), //没有action，左右4上下2  1行上下左右4   2行左右8上下3
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), //没有action 8  一行10  2行12
        color: backgroundColor,
      ),
      child: Row(children: [
        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Row(children: [
                SvgPicture.asset(
                  icon, width: 16, height: 16,
                  colorFilter: ColorFilter.mode(
                    iconColor, BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8,),
                Text(title, style: AppTextStyles.red13.copyWith(color: iconColor)),
              ],),
            ),
        ),
        if (actionIcon case final String icon) ...<Widget>[
            const SizedBox(
              width: 8,
            ),
            action == null
                ? PaddedSvgIcon(icon,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ))
                : ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 46, minHeight: 28),
                    child: IconButtonx(
                      child: action!,
                      icon: icon,
                      size: Sizex.custom,
                      buttonSize: ButtonxSize(
                        padding: 12,
                        compact: true,
                        height: double.infinity,
                        textSize: AppTextStyles.red13500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      type: type == AlertViewType.danger
                          ? ButtonxType.danger
                          : ButtonxType.info,
                      enabled: true,
                    ),
                  ),
          ],
        ],),
    );
  }

}