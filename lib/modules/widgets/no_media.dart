
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';


class NoMedia extends StatelessWidget {

  final double width;
  final double height;

  const NoMedia({super.key, required this.width, required this.height,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      color: AppColors.black04,
      alignment: Alignment.center,
      child: SvgPicture.asset(SvgIcons.noMedia,),
    );
  }

}