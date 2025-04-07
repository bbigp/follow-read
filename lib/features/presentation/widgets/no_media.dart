
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

import '../../../config/svgicons.dart';

class NoMedia extends StatelessWidget {

  final double width;
  final double height;

  const NoMedia({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, height: height,
      child: Center(
        child: SvgPicture.asset(
          Svgicons.noMedia,
          height: height*0.16, width: width*0.25,
        ),
      ),
    );
  }

}