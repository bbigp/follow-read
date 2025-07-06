

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';

import 'buttonx.dart';

class Tickbox extends StatefulWidget {

  final String value;
  final bool tristate;//选中的值
  final ValueChanged<String>? onChanged;
  final Sizex sizex;
  const Tickbox({super.key, required this.value, this.tristate = false,
    this.onChanged, this.sizex = Sizex.medium,
  });
  @override
  State<Tickbox> createState() => _TickboxState();
}

class _TickboxState extends State<Tickbox> {

  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.tristate;
  }

  @override
  void didUpdateWidget(covariant Tickbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tristate != widget.tristate) {
      setState(() {
        _selected = widget.tristate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = switch(widget.sizex) {
      _ => 28,//medium
    };
    Widget child = SizedBox(width: size, height: size,
      child: SvgPicture.asset(_selected ? SvgIcons.selection_check : SvgIcons.selection_off,
        width: size, height: size, fit: BoxFit.contain,
      ),
    );
    return widget.onChanged == null ? child : GestureDetector(onTap: (){
      HapticFeedback.mediumImpact();
      setState(() {
        _selected = !_selected;
      });
      widget.onChanged?.call(widget.value);
    }, child: child,);
  }

}