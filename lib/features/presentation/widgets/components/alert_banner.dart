
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
  final String actionIcon;

  const AlertView({super.key,
    required this.icon,
    required this.title,
    required this.actionIcon,
    this.type = AlertViewType.danger,
    this.action,
  });


  @override
  Widget build(BuildContext context) {
    Color iconColor = type == AlertViewType.danger ? AppTheme.red : AppTheme.blue;
    Color backgroundColor = type == AlertViewType.danger ? AppTheme.red10 : AppTheme.blue10;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: Row(children: [
            SvgPicture.asset(
              icon, width: 16, height: 16,
              colorFilter: ColorFilter.mode(
                iconColor, BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8, height: 18,),
            Expanded(child: Text(title, style: AppTextStyles.red13.copyWith(color: iconColor))),
          ],),
        ),
        if (actionIcon case final String icon) ...<Widget>[
            const SizedBox(
              width: 8,
            ),
            action == null
                ? PaddedSvgIcon(actionIcon,
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
    // return IntrinsicHeight(
    //   child: Stack(children: [
    //     Container(
    //       color: AppTheme.white0,
    //       width: double.infinity,
    //     ),
    //     Positioned(
    //       child: Container(
    //         // height: 28,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: AppTheme.red10,
    //         ),
    //         padding: EdgeInsets.all(4),
    //         margin: EdgeInsets.symmetric(horizontal: 12),
    //         child: Row(children: [
    //           const SizedBox(width: 4,),
    //           SvgPicture.asset(Svgicons.alertFill, width: 16, height: 16,),
    //           const SizedBox(width: 8,),
    //           Expanded(child: Text(data, maxLines: 5, style: AppTextStyles.red13,),),
    //           Visibility(
    //             visible: buttonText.isNotEmpty,
    //             child: const SizedBox(width: 8,),
    //           ),
    //           Visibility(visible: buttonText.isNotEmpty,
    //               child: SvgIconButton(label: buttonText,
    //                 height: 28,
    //                 borderRadius: BorderRadius.circular(6),
    //                 backgroundColor: AppTheme.red10,
    //                 icon: Svgicons.reset, iconSize: 16,
    //                 textStyle: AppTextStyles.red13500,
    //                 padding: EdgeInsets.only(left: 12, right: 16),
    //               )
    //           ),
    //         ],),
    //       ),
    //     )
    //   ],),
    // );
  }

}