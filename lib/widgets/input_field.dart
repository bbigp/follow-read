

import 'package:flutter/material.dart';
import 'package:follow_read/widgets/svgicon.dart';

import '../config/svgicons.dart';
import '../config/theme.dart';

class InputField extends StatefulWidget  {

  final void Function(String) onChanged;
  final String? hintText;
  final TextInputType textInputType;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;
  final EdgeInsets suffixIconPadding;
  final double suffixIconSize;
  final double suffixSize;
  final EdgeInsets prefixPadding;
  final String? prefixIcon;
  final double prefixSize;
  final double prefixIconSize;
  final ValueChanged<String>? onSubmitted;
  final String data;
  final double height;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final bool readOnly;
  const InputField({super.key,
    this.data = "",
    required this.onChanged,
    this.hintText,
    this.textInputType =TextInputType.text,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.contentPadding = EdgeInsets.zero,
    this.suffixIconPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.suffixIconSize = 20,
    this.suffixSize = 24,
    this.prefixPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.prefixIcon,
    this.prefixSize = 24,
    this.prefixIconSize = 24,
    this.onSubmitted,
    this.height = 40,
    this.readOnly = false,
  }) : textStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppTheme.black95,
  ), hintStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppTheme.black25,
  );

  @override
  State<StatefulWidget> createState() => _InputFieldState();

}


class _InputFieldState extends State<InputField> {

  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.data);
    _controller.addListener(() {
      final text = _controller.text;
      final hasText = text.isNotEmpty;
      if (hasText != _hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
      widget.onChanged(text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data && widget.data != _controller.text) {
      _controller.text = widget.data;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  void _clearText() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // CupertinoSearchTextField
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: AppTheme.black4,
      ),
      child: Row(children: [
        widget.prefixIcon == null ? SizedBox.shrink() : Container(
          padding: widget.prefixPadding,
          child: Svgicon(widget.prefixIcon!, size: widget.prefixSize, iconSize: widget.prefixIconSize),
        ),
        Expanded(child: TextField(
            readOnly: widget.readOnly,
            controller: _controller,
            maxLines: 1,
            keyboardType: widget.textInputType,
            textInputAction: TextInputAction.done,
            onSubmitted: widget.onSubmitted,
            style: widget.textStyle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: widget.contentPadding,
              hintText: widget.hintText ?? '',
              hintStyle: widget.hintStyle,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            )
        ),),
        _hasText && !widget.readOnly
            ? GestureDetector(
          onTap: _clearText,
          child: Container(
            padding: widget.suffixIconPadding,
            child: Svgicon(Svgicons.x_fill, size: widget.suffixSize, iconSize: widget.suffixIconSize, ),
          ),
        )
            : SizedBox(width: widget.suffixSize,),
      ],),
    );
  }

}