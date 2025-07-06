import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';

import 'buttonx.dart';
import 'padded_svg_icon.dart';

class TextFieldx extends StatefulWidget  {

  final Sizex sizex;
  final Widget? icon;
  final bool readOnly;
  final TextInputType textInputType;
  final ValueChanged<String>? onSubmitted;
  final String hint;
  final String value;
  final void Function(String)? onChanged;

  const TextFieldx({super.key,
    required this.sizex, this.icon,
    this.readOnly = false,
    this.textInputType =TextInputType.text,
    this.onSubmitted,
    this.hint = "",
    this.value = "",
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _TextFieldxState();

}


class _TextFieldxState extends State<TextFieldx> {

  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _controller.addListener(() {
      final text = _controller.text;
      final hasText = text.isNotEmpty;
      if (hasText != _hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
      if (widget.onChanged != null) {
        widget.onChanged!(text);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TextFieldx oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );//光标移动到最后
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = switch(widget.sizex) {
      Sizex.small => 36,
      Sizex.custom => 44,
      _ => 52,
    };
    double borderRadius = switch(widget.sizex) {
      Sizex.small => 10,
      _ => 12
    };
    double contentBottomPadding = switch(widget.sizex) {
      Sizex.small => (height - 15) / 2 + 2,
      _ => 0//(height - 15) / 2
    };
    EdgeInsets padding = switch(widget.sizex) {
      Sizex.small => EdgeInsets.symmetric(horizontal: 8),
      _ => EdgeInsets.symmetric(horizontal: 12)
    };
    Widget clearIcon = switch(widget.sizex) {
      Sizex.small => PaddedSvgIcon(SvgIcons.x_fill, padding: 2, width: 20,
        height: 20, fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn,),
      ),
      _ => PaddedSvgIcon(SvgIcons.x_fill, fit: BoxFit.contain, colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn,),)
    };
    TextStyle textStyle = widget.readOnly ? AppTextStyles.caption : AppTextStyles.text;
    TextStyle hintStyle = AppTextStyles.hint;
    EdgeInsets contentPadding = EdgeInsets.only(right: 8, left: 4, bottom: contentBottomPadding);

    Color background = AppColors.black04;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: background,
      ),
      padding: padding,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        if (widget.icon case final Widget child) ...[
          child,
          const SizedBox(width: 4,),
        ],
        Expanded(child: TextField(
            readOnly: widget.readOnly,
            controller: _controller,
            maxLines: 1,
            keyboardType: widget.textInputType, //设置键盘类型
            textInputAction: TextInputAction.done, //决定键盘右下角“完成”按钮的样式
            onSubmitted: widget.onSubmitted,
            style: textStyle,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              hintText: widget.hint,
              hintStyle: hintStyle,
              border: InputBorder.none, //默认边框样式
              enabledBorder: InputBorder.none, //输入框启用时边框样式
              focusedBorder: InputBorder.none, //获取焦点时边框样式
            )
        )),
        _hasText && !widget.readOnly
            ? GestureDetector(onTap: () => _controller.clear(),
                child: clearIcon,
              )
            : const SizedBox.shrink(),
      ],),
    );
  }

}