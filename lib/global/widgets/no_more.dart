

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/svg_icons.dart';

///
class NoMore extends StatelessWidget {
  const NoMore({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, width: double.infinity,
      child: Center(
        child: SvgPicture.asset(SvgIcons.vector, width: 14, height: 14, fit: BoxFit.contain,),
      ),
    );
  }

}