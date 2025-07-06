
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';

import 'buttonx.dart';

///
class Radiox extends StatefulWidget {

  final String value;
  final String groupValue;//选中的值
  final ValueChanged<String>? onChanged;
  final Sizex sizex;
  const Radiox({super.key, required this.value, required this.groupValue,
    this.onChanged, this.sizex = Sizex.medium,
  });
  @override
  State<Radiox> createState() => _RadioxState();
}

class _RadioxState extends State<Radiox> {

  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.groupValue == widget.value;
  }

  @override
  void didUpdateWidget(covariant Radiox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.groupValue != widget.groupValue) {
      setState(() {
        _selected = widget.groupValue == widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = switch(widget.sizex) {
      _ => 28,//medium
    };
    Widget child = SizedBox(width: size, height: size,
      child: SvgPicture.asset(_selected ? SvgIcons.selection_radio : SvgIcons.selection_off,
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