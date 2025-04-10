import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';

class AddText extends StatelessWidget {

  final GestureTapCallback? onTap;
  final String data;

  const AddText(this.data, {super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(width: 8,),
          SvgPicture.asset(
            Svgicons.plusO,
            height: 20, width: 20,
          ),
          SizedBox(width: 8,),
          Text(data, style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black95,
          ),),
          SizedBox(width: 8,),
        ],
      ),
    );
  }



}