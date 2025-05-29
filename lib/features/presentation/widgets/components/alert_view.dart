
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/components/buttonx.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/theme/text_styles.dart';

///
enum AlertTipType { normal, danger, }
class AlertTip extends StatelessWidget {

  final String icon;
  final String title;
  final AlertTipType type;
  // final String? action;
  // final String? actionIcon;
  final Sizex size;
  final AlertTipActionButton? action;
  final bool skeleton;

  const AlertTip({super.key,
    required this.icon,
    required this.title,
    // this.actionIcon,
    this.type = AlertTipType.danger,
    this.action,
    this.size = Sizex.medium,
    this.skeleton = false,
  });

  double get iconSize => switch(size) {
    Sizex.large => 20,
    _ => 16,
  };

  Widget _buildSkeleton(){
    return Container(
      color: Colors.white,
      child: Row(children: [
        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Row(children: [
                SizedBox(width: iconSize, height: iconSize,),
                const SizedBox(width: 8,),
                Text(title, style: AppTextStyles.red13.copyWith(color: Colors.white)),
              ],),
            )
        ),
        if (action case final AlertTipActionButton button) ...<Widget>[
          const SizedBox(width: 8,),
          button.skeleton(size),
        ],
      ],),
    );
  }

  //实现的是一行中号   没有action是小号   2行是2号
  @override
  Widget build(BuildContext context) {
    Color iconColor = type == AlertTipType.danger ? AppTheme.red : AppTheme.blue;
    Color backgroundColor = type == AlertTipType.danger ? AppTheme.red10 : AppTheme.blue10;
    final padding = switch(size) {
      Sizex.small => EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      Sizex.large => EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      _ => EdgeInsets.all(4),
    };
    double borderRadius = switch(size) {
      Sizex.small => 8,
      Sizex.large => 10,
      _ => 12,
    };
    double iconSize = switch(size) {
      Sizex.large => 20,
      _ => 16,
    };
    if (skeleton) {
      return _buildSkeleton();
    }
    return Container(
      padding: padding, //没有action，左右4上下2  1行上下左右4   2行左右8上下3
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius), //没有action 8  一行10  2行12
        color: backgroundColor,
      ),
      child: Row(children: [
        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Row(children: [
                SvgPicture.asset(
                  icon, width: iconSize, height: iconSize,
                  colorFilter: ColorFilter.mode(
                    iconColor, BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8,),
                Text(title, style: AppTextStyles.red13.copyWith(color: iconColor)),
              ],),
            ),
        ),
        if (action case final AlertTipActionButton button) ...<Widget>[
            const SizedBox(width: 8,),
            button.build(size, iconColor, type),
          ],
        ],),
    );
  }

}

class AlertTipActionButton {
  final String? child;
  final String icon;
  final GestureTapCallback? onTap;
  const AlertTipActionButton({this.child, required this.icon,
    this.onTap,
  });

  ButtonxSize getButtonSize(Sizex size) {
    return switch(size) {
      Sizex.medium => ButtonxSize(
        padding: 12,
        compact: true,
        height: 28,
        textSize: AppTextStyles.red13500,
        borderRadius: BorderRadius.circular(6),
      ),
      _ => ButtonxSize(
        padding: 16,
        compact: true,
        height: 36,
        textSize: AppTextStyles.red13500,
        borderRadius: BorderRadius.circular(8),
      ),
    };
  }


  Widget skeleton(Sizex size){
    if (size == Sizex.small) {
      return const SizedBox.shrink();
    }
    if (child == null) {
      return const SizedBox(width: 24, height: 24,);
    }
    final buttonSize = getButtonSize(size);
    return IconButtonx(
      child: child!,
      icon: icon,
      size: Sizex.custom,
      buttonSize: buttonSize,
      type: ButtonxType.skeleton,
      enabled: false,
    );
  }

  Widget build(Sizex size, Color color, AlertTipType type) {
    if (size == Sizex.small) {
      return const SizedBox.shrink();
    }
    final Widget widget;
    if (child == null) {
      widget = PaddedSvgIcon(icon, width: 20, height: 20, colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ));
    } else {
      final buttonSize = getButtonSize(size);
      widget = IconButtonx(
        child: child!,
        icon: icon,
        size: Sizex.custom,
        buttonSize: buttonSize,
        type: type == AlertTipType.danger
            ? ButtonxType.danger
            : ButtonxType.info,
        enabled: true,
      );
    }
    return onTap == null ? widget : GestureDetector(
      onTap: onTap,
      child: widget,
    );
  }

}