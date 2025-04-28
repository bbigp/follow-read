
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/theme/text_styles.dart';

//               CupxButton.text('Done',
//                 buttonState: ButtonState.enabled,
//                 style: CupxButtonStyle.primarySmall,
//                 onPressed: () async {
//
//                 },
//               ),

enum ButtonState { enabled, disabled, loading }

class CupxButtonSize {

  final bool compact;
  final double? height;
  final double? width;
  final double padding;

  const CupxButtonSize({
    this.compact = false, //宽度是包住组件就行
    this.padding = 0,
    this.width,
    this.height,
  });

  CupxButtonSize copyWith({
    bool? compact,
    double? height,
    double? width,
    double? padding,
  }) {
    return CupxButtonSize(
      compact: compact ?? this.compact,
      height: height ?? this.height,
      width: width ?? this.width,
      padding: padding ?? this.padding,
    );
  }

  static CupxButtonSize small = CupxButtonSize(height: 36, width: double.infinity,);

  static CupxButtonSize smallCompact = CupxButtonSize(height: 36, compact: true, padding: 16);

  static CupxButtonSize medium = CupxButtonSize(height: 44, width: double.infinity,);

  static CupxButtonSize mediumCompact = CupxButtonSize(height: 44, compact: true, padding: 16);

  static CupxButtonSize large = CupxButtonSize(height: 52, width: double.infinity,);

}

class CupxButtonStyle {

  final BorderRadiusGeometry? borderRadius;
  final Color color;//正常背景色
  final Color disabledColor;//禁用的背景色
  final TextStyle textStyle;
  final TextStyle disabledTextStyle;
  final CupxButtonSize size;

  const CupxButtonStyle({
    this.size = const CupxButtonSize(height: 0),
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.color = Colors.blue,
    this.disabledColor = Colors.red,
    this.textStyle = AppTextStyles.white500,
    this.disabledTextStyle = AppTextStyles.hint500,
  });

  CupxButtonStyle copyWith({
    BorderRadiusGeometry? borderRadius,
    Color? color,
    Color? disabledColor,
    TextStyle? textStyle,
    TextStyle? disabledTextStyle,
    CupxButtonSize? size,
  }) {
    return CupxButtonStyle(
      borderRadius: borderRadius ?? this.borderRadius,
      color: color ?? this.color,
      disabledColor: disabledColor ?? this.disabledColor,
      textStyle: textStyle ?? this.textStyle,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      size: size ?? this.size,
    );
  }

  static CupxButtonStyle primarySmailCompact = CupxButtonStyle(
    borderRadius: BorderRadius.circular(10),
    color: AppTheme.black95,
    disabledColor: AppTheme.black8,
    textStyle: AppTextStyles.white500,
    disabledTextStyle: AppTextStyles.hint500,
    size: CupxButtonSize.smallCompact,
  );

  static CupxButtonStyle primaryMediumCompact = CupxButtonStyle(
    borderRadius: BorderRadius.circular(10),
    color: AppTheme.black95,
    disabledColor: AppTheme.black8,
    textStyle: AppTextStyles.white500,
    disabledTextStyle: AppTextStyles.hint500,
    size: CupxButtonSize.mediumCompact,
  );

  static CupxButtonStyle primaryLarge = CupxButtonStyle(
    borderRadius: BorderRadius.circular(12),
    color: AppTheme.black95,
    disabledColor: AppTheme.black8,
    textStyle: AppTextStyles.white17500,
    disabledTextStyle: AppTextStyles.hint17500,
    size: CupxButtonSize.large,
  );

}


class CupxButton extends StatefulWidget {

  final Future<void> Function()? onPressed;
  final CupxButtonStyle style;
  final ButtonState buttonState;
  final String label;

  const CupxButton({
    super.key,
    this.onPressed,
    this.style = const CupxButtonStyle(),
    this.buttonState = ButtonState.enabled,
    this.label = "",
  });
  
  factory CupxButton.text(String text, {
    bool enabled = false,
    Future<void> Function()? onPressed,
    required CupxButtonStyle style,
  }) {
    return CupxButton(
      buttonState: enabled ? ButtonState.enabled : ButtonState.disabled,
      label: text,
      onPressed: onPressed,
      style: style,
    );  
  }

  @override
  State<CupxButton> createState() => _CupxButtonState();

}

class _CupxButtonState extends State<CupxButton> with SingleTickerProviderStateMixin {

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
    _buttonState = widget.buttonState;
  }

  @override
  void didUpdateWidget(covariant CupxButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.buttonState != oldWidget.buttonState) {
      _buttonState = widget.buttonState;
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

    final Color backgroundColor = enabled ? widget.style.color : widget.style.disabledColor;
    final TextStyle textStyle = enabled ? widget.style.textStyle : widget.style.disabledTextStyle;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled && !loading ? (_) => _animate(true) : null,
      onTapUp: enabled && !loading ? (_) => _animate(false) : null,
      onTapCancel: enabled && !loading ? () => _animate(false) : null,
      onTap: _handlePress,
      child: SizedBox(
        height: widget.style.size.height, width: widget.style.size.width,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: widget.style.borderRadius,
              color: backgroundColor,
            ),
            child: Center(
              child: loading
                  ? const CupertinoActivityIndicator(radius: 10)
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(width: widget.style.size.padding,),
                Text(widget.label, style: textStyle,),
                SizedBox(width: widget.style.size.padding,),
              ],),
            ),
          ),
        ),
      ),
    );
  }


}