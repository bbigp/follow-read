import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/logger.dart';

import '../../../config/svgicons.dart';

class CircleRadio extends StatefulWidget {
  final bool choose; // 当前是否选中
  final ValueChanged<bool> onChanged; // 点击后传出新的状态
  final double size;

  const CircleRadio({
    super.key,
    this.choose = false,
    required this.onChanged,
    this.size = 28,
  });

  @override
  State<StatefulWidget> createState() => _CircleRadioState();
}

class _CircleRadioState extends State<CircleRadio> {

  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = widget.choose;
  }

  @override
  void didUpdateWidget(covariant CircleRadio oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.choose != widget.choose) {
      _checked = widget.choose;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          logger.i('set $_checked');
          _checked = !_checked;
          logger.i('set $_checked');
        });
        widget.onChanged(_checked);
      },
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        _checked ? Svgicons.selection : Svgicons.circular,
        height: widget.size,
        width: widget.size,
      ),
    );
  }

}