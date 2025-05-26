

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
class PaddedSvgIcon extends StatelessWidget {

  final String icon;
  final double padding;
  final double width;
  final double height;
  final BoxFit fit;
  final GestureTapCallback? onTap;
  final ColorFilter? colorFilter;
  const PaddedSvgIcon(this.icon, {super.key, this.padding = 4,
    this.width = 24, this.height = 24, this.fit = BoxFit.contain,
    this.onTap, this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = Padding(
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset(icon, width: width, height: height, fit: fit, colorFilter: colorFilter,),
    );
    return onTap == null ? widget : InkWell(
      onTap: onTap,
      child: widget,
    );
  }

}