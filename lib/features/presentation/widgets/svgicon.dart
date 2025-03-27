

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Svgicon extends StatelessWidget {

  final String assetName;
  final double size;
  final double iconSize;

  const Svgicon(this.assetName, {super.key, this.size = 28, this.iconSize = 24,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: SvgPicture.asset(
      assetName,
      height: iconSize, width: iconSize,
    ),);
  }

}