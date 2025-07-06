

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';

class SyncIcon extends StatefulWidget {

  final bool isSyncing;
  final VoidCallback? onTap;
  const SyncIcon({super.key, this.isSyncing = false, this.onTap});

  @override
  State<SyncIcon> createState() => _SyncIconState();
}

class _SyncIconState extends State<SyncIcon> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void didUpdateWidget(covariant SyncIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSyncing && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isSyncing && _controller.isAnimating) {
      _controller.stop();
    }
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isSyncing ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.14159,
            child: child,
          );
        },
        child: Padding(padding: EdgeInsets.all(2),
          child: SizedBox(
            width: 24, height: 24,
            child: SvgPicture.asset(SvgIcons.sync, width: 24, height: 24, fit: BoxFit.none,)
          ),
        )
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


}