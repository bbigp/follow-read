
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

extension CupxButtonSize on Size{
  static Size smallSize = const Size(double.infinity, 36);
}

class CupxButtonStyle {

  final Size size;
  final BorderRadiusGeometry? borderRadius;
  final Color color;//正常背景色
  final Color disabledColor;//禁用的背景色
  final TextStyle textStyle;
  final TextStyle disabledTextStyle;

  const CupxButtonStyle({
    this.size = const Size(double.infinity, 40),
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.color = Colors.blue,
    this.disabledColor = Colors.red,
    this.textStyle = AppTextStyles.white500,
    this.disabledTextStyle = AppTextStyles.hint500,
  });

  static CupxButtonStyle primarySmall = CupxButtonStyle(
    size: CupxButtonSize.smallSize,
    borderRadius: BorderRadius.circular(10),
    color: AppTheme.black95,
    disabledColor: AppTheme.black8,
    textStyle: AppTextStyles.white500,
    disabledTextStyle: AppTextStyles.hint500,
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
    ButtonState buttonState = ButtonState.disabled,
    Future<void> Function()? onPressed,
    required CupxButtonStyle style,
  }) {
    return CupxButton(buttonState: buttonState, label: text,
        onPressed: onPressed, style: style,
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
                  : Row(children: [
                 const SizedBox(width: 16,),
                Text(widget.label, style: textStyle,),
                const SizedBox(width: 16,),
              ],),
            ),
          ),
        ),
      ),
    );
  }


}