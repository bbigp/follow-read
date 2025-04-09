

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';

class ModalTile extends StatelessWidget {

  final String assetName;
  final String title;
  final GestureTapCallback? onTap;

  const ModalTile(this.assetName, this.title,
      {super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 16, height: 36,),
          SvgPicture.asset(assetName, width: 24, height: 24,),
          SizedBox(width: 12,),
          Expanded(child: Text(title, style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
          ),)),
          SizedBox(width: 4,),
          SvgPicture.asset(Svgicons.chevronUpDown, width: 20, height: 20,),
          SizedBox(width: 12,),
        ],
      ),
    );
  }

}