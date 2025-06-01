
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/theme/text_styles.dart';

///
enum ButtonState { enabled, disabled, loading }
enum ButtonxType {
  primary, secondary, ghost, stroked, danger, dangerGhost, info, skeleton,
}
enum Sizex {
  small, smallCompact, medium, mediumCompact, large, largeCompact, custom,
}
typedef ButtonColor = ButtonxColor Function();
typedef ButtonSize = ButtonxSize Function();


class TextButtonx extends StatelessWidget {
  final String child;
  final Future<void> Function()? onPressed;
  final bool enabled;
  final Sizex size;
  final ButtonxType type;
  final ButtonxSize? buttonSize;
  const TextButtonx({super.key, required this.child, this.onPressed,
    this.enabled = false, required this.size, this.type = ButtonxType.primary,
    this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    return Buttonx(child: child, onPressed: onPressed,
      state: enabled ? ButtonState.enabled : ButtonState.disabled,
      size: size, type: type, buttonSize: buttonSize,
    );
  }

}

class IconButtonx extends StatelessWidget {
  final String child;
  final Future<void> Function()? onPressed;
  final bool enabled;
  final Sizex size;
  final ButtonxSize? buttonSize;
  final ButtonxType type;
  final String icon;
  final bool isLeftIcon;
  const IconButtonx({super.key, required this.child, required this.icon, this.onPressed,
    this.enabled = false, required this.size, required this.type,
    this.isLeftIcon = true, this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    return Buttonx(
      onPressed: onPressed, state: enabled ? ButtonState.enabled : ButtonState.disabled,
      size: size, type: type, child: child,
      leftIcon: isLeftIcon ? icon : null, rightIcon: isLeftIcon ? null : icon,
      buttonSize: buttonSize,
    );
  }
}

class Buttonx extends StatefulWidget {

  final Future<void> Function()? onPressed;
  final ButtonState state;
  final Sizex size;
  final ButtonxSize? buttonSize;
  final ButtonxType type;

  final String? leftIcon;
  final String child;
  final String? rightIcon;

  const Buttonx({super.key, this.leftIcon, this.child = "", this.rightIcon,
    this.onPressed, this.state = ButtonState.enabled,
    required this.size, required this.type, this.buttonSize,
  });

  @override
  State<Buttonx> createState() => _ButtonxState();

}

class _ButtonxState extends State<Buttonx> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  ButtonState _buttonState = ButtonState.disabled;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(Tween<double>(begin: 1.0, end: 0.4));//按下按钮时淡出的不透明度。
    _buttonState = widget.state;
  }

  @override
  void didUpdateWidget(covariant Buttonx oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      _buttonState = widget.state;
    }
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animate(bool pressed) {
    if (_animationController.isAnimating) {
      return;
    }
    final target = pressed ? 1.0 : 0.0;
    final duration = pressed ? const Duration(milliseconds: 120) : const Duration(milliseconds: 180);
    _animationController.animateTo(target, duration: duration, curve: Curves.easeOutCubic);
  }

  void _handlePress() async {
    if (_buttonState == ButtonState.enabled && widget.onPressed != null) {
      setState(() {
        _buttonState = ButtonState.loading;
      });
      await widget.onPressed?.call();
      if (mounted) {
        setState(() {
          _buttonState = ButtonState.enabled;
        });
        _animationController.value = 0.0;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final bool enabled = _buttonState == ButtonState.enabled;
    final bool loading = _buttonState == ButtonState.loading;

    ButtonxColor color = switch(widget.type) {
      ButtonxType.secondary => secondary(),
      ButtonxType.ghost => ghost(),
      ButtonxType.stroked => stroked(),
      ButtonxType.danger => danger(),
      ButtonxType.dangerGhost => dangerGhost(),
      ButtonxType.info => info(),
      ButtonxType.skeleton => skeleton(),
      _ => primary(),
    };
    ButtonxSize size = switch(widget.size) {
      Sizex.large => large(),
      Sizex.largeCompact => largeCompact(),
      Sizex.medium => medium(),
      Sizex.mediumCompact => mediumCompact(),
      Sizex.small => small(),
      Sizex.smallCompact => smallCompact(),
      _ => widget.buttonSize ?? ButtonxSize(),
    };
    final Color backgroundColor = enabled ? color.backgroundColor : color.disabledBackgroundColor;
    final Color textColor = enabled ? color.color : color.disabledColor;
    final TextStyle textStyle = size.textSize.copyWith(color: textColor);

    Widget child = SizedBox(
      height: size.height, width: size.width,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: size.borderRadius,
            color: backgroundColor,
          ),
          child: Center(
            child: loading
                ? const CupertinoActivityIndicator(radius: 10)
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (size.padding > 0)
                  SizedBox(width: size.padding,),
                if (widget.leftIcon case final String icon) ...<Widget>[
                  SvgPicture.asset(icon, width: 20, height: 20,),
                  const SizedBox(width: 8,),
                ],
                if (widget.child != "")
                  Text(widget.child, style: textStyle,),
                if (widget.rightIcon case final String trailing) ...<Widget>[
                  const SizedBox(width: 8,),
                  SvgPicture.asset(trailing, width: 20, height: 20,),
                ],
                if (size.padding > 0)
                  SizedBox(width: size.padding,),
              ],),
          ),
        ),
      ),
    );


    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled && !loading ? (_) => _animate(true) : null,
      onTapUp: enabled && !loading ? (_) => _animate(false) : null,
      onTapCancel: enabled && !loading ? () => _animate(false) : null,
      onTap: _handlePress,
      child: size.compact ? IntrinsicWidth(child: child,) : child,
    );
  }

}


ButtonxSize small() {
  return ButtonxSize(height: 36, width: double.infinity,
    borderRadius: BorderRadius.circular(8), textSize: AppTextStyles.red13500,
  );
}
ButtonxSize smallCompact() {
  return ButtonxSize(height: 36, compact: true, padding: 16,
    borderRadius: BorderRadius.circular(8), textSize: AppTextStyles.red13500,
  );
}
ButtonxSize medium() {
  return ButtonxSize(height: 44, width: double.infinity,
    borderRadius: BorderRadius.circular(10), textSize: AppTextStyles.text500,
  );
}
ButtonxSize mediumCompact() {
  return ButtonxSize(height: 44, compact: true, padding: 16,
    borderRadius: BorderRadius.circular(10), textSize: AppTextStyles.text500,
  );
}
ButtonxSize large() {
  return ButtonxSize(height: 52, width: double.infinity,
    borderRadius: BorderRadius.circular(12), textSize: AppTextStyles.text17500,
  );
}
ButtonxSize largeCompact() {
  return ButtonxSize(height: 52, compact: true, padding: 16,
    borderRadius: BorderRadius.circular(12), textSize: AppTextStyles.text17500,
  );
}

ButtonxColor primary() { //黑色背景 白色字体
  return ButtonxColor(
    color: Colors.white, disabledColor: AppTheme.black25,
    backgroundColor: AppTheme.black95, disabledBackgroundColor: AppTheme.black8,
  );
}
ButtonxColor secondary() { //灰色背景 黑色字体
  return ButtonxColor(
    color: AppTheme.black95, disabledColor: AppTheme.black25,
    backgroundColor: AppTheme.black4, disabledBackgroundColor: AppTheme.black4,
  );
}
ButtonxColor ghost() { //透明背景 黑色字体
  return ButtonxColor(
      color: AppTheme.black95, disabledColor: AppTheme.black25,
      backgroundColor: Colors.transparent, disabledBackgroundColor: Colors.transparent
  );
}
ButtonxColor stroked() {//透明背景 黑色字体 带描边
  return ButtonxColor(
    color: AppTheme.black95, disabledColor: AppTheme.black25,
    backgroundColor: Colors.transparent, disabledBackgroundColor: AppTheme.black4,
    borderColor: AppTheme.black8,
  );
}
ButtonxColor danger() { //红色背景 红色字体
  return ButtonxColor(
    color: AppTheme.red, disabledColor: AppTheme.black25,
    backgroundColor: AppTheme.red10, disabledBackgroundColor: AppTheme.black4,
  );
}
ButtonxColor info() {
  return ButtonxColor(
      color: AppTheme.blue, disabledColor: AppTheme.black25,
      backgroundColor: AppTheme.blue10, disabledBackgroundColor: AppTheme.black4,
  );
}
ButtonxColor dangerGhost() { //透明背景 红色字体
  return ButtonxColor(
    color: AppTheme.red, disabledColor: AppTheme.black25,
    backgroundColor: Colors.transparent, disabledBackgroundColor: Colors.transparent,
  );
}

ButtonxColor skeleton(){
  return ButtonxColor(
    color: Colors.white, disabledColor: Colors.white,
    backgroundColor: Colors.white, disabledBackgroundColor: Colors.white,
  );
}

class ButtonxColor {

  final Color color;
  final Color disabledColor;
  final Color backgroundColor;//正常背景色
  final Color disabledBackgroundColor;//禁用的背景色
  final Color? borderColor;

  const ButtonxColor({
    required this.color,
    required this.disabledColor,
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    this.borderColor,
  });
}

class ButtonxSize {

  final bool compact;
  final double? height;
  final double? width;
  final double padding;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle textSize;

  const ButtonxSize({
    this.compact = false, //宽度是包住组件就行
    this.padding = 0,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.textSize = const TextStyle(),
  });

  ButtonxSize copyWith({bool? compact, double? height, double? width, double? padding,
    BorderRadiusGeometry? borderRadius, TextStyle? textSize,
  }) {
    return ButtonxSize(
      compact: compact ?? this.compact,
      height: height ?? this.height, width: width ?? this.width,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textSize: textSize ?? this.textSize,
    );
  }

}